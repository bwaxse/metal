%%writefile run_metal.sh

#!/bin/bash
set -euo pipefail

echo "Starting METAL meta-analysis for ${TRAIT}"
echo "Number of input files: ${N_FILES}"

# Parse ancestries
IFS=',' read -ra INPUTS <<< "${INPUTS}"

# Parse sample sizes
IFS=',' read -ra SIZES <<< "${SAMPLE_SIZES}"

echo "Preprocessing files to add ancestry-specific n_total columns..."
PROCESSED_FILES=()

# Pre-processing adds sample size via n_cases and n_controls extracted from SAIGE GWAS results 
for i in "${!INPUTS[@]}"; do
    var_name="${INPUTS[$i]}"
    input_file="${!var_name}"
    n_total="${SIZES[$i]}"
    processed_file="/tmp/processed_file_${i}.tsv"
    
    echo "Processing file $((i+1)): ${input_file} (n_total=${n_total})"
    
    # Check if file exists
    if [[ ! -f "${input_file}" ]]; then
        echo "ERROR: Input file not found: ${input_file}"
        echo "Available files in /mnt/data/input/:"
        ls -la /mnt/data/input/ || echo "Input directory not accessible"
        exit 1
    fi
    
    # Add constant n_total column for this ancestry
    if [[ "${input_file}" == *.gz ]]; then
        gzip -dc "${input_file}"
    else
        cat "${input_file}"
    fi | awk -F'\t' -v OFS='\t' -v n_total="${n_total}" '
        NR==1 { print $0, "n_total"; next }
               { print $0, n_total }' > "${processed_file}"
    
    PROCESSED_FILES+=("/processed_file_${i}.tsv")
    
    # Verify output
    n_lines=$(wc -l < "${processed_file}")
    echo "  Created ${processed_file} with ${n_lines} lines"
done

# Convert processed files array to comma-separated string
PROCESSED_FILES_STR=$(IFS=','; echo "${PROCESSED_FILES[*]}")
echo "Running METAL with processed files: ${PROCESSED_FILES_STR}"

# Create a METAL script dynamically
METAL_SCRIPT="${OUTPUT_PATH}/metal_script.txt"
cat > "${METAL_SCRIPT}" <<EOF
MARKER vid
WEIGHT n_total
ALLELE effect_allele other_allele
FREQ effect_allele_frequency
PVAL p_value
EFFECT beta
STDERR standard_error
SEPARATOR TAB
SCHEME STDERR

# Auto-flip alleles based on frequency
AVERAGEFREQ ON
MINMAXFREQ ON

$(for file in "${PROCESSED_FILES[@]}"; do echo "PROCESS $file"; done)

OUTFILE ${OUT_PREF} .tsv
ANALYZE HETEROGENEITY
QUIT
EOF

echo "Metal script created"

# Run METAL
metal "${METAL_SCRIPT}"

mv ${OUT_PREF}1.tsv "${OUTPUT_PATH}/"
mv ${OUT_PREF}1.tsv.info "${OUTPUT_PATH}/"

# List all output files
echo "Final contents of OUTPUT_PATH (${OUTPUT_PATH}):"
ls -lh "${OUTPUT_PATH}" || echo "OUTPUT_PATH not accessible"

echo "METAL analysis completed successfully for ${TRAIT}"
