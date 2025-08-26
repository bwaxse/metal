# METAL Docker Workflow

This repository provides a Dockerized workflow for running **METAL** meta-analysis using SAIGE-formatted GWAS results. It includes helper scripts in Python, a shell entrypoint, and a demo Jupyter notebook.

## Repository Structure
```metal/
├── Dockerfile # Dockerfile to build METAL image
├── run_metal.sh # Shell script to run METAL analysis
├── metal_utils.py # Python helper functions for validation and job submission
├── examples/ # Example usage and demo files
│ ├── demo_metal.ipynb # Jupyter notebook showing workflow with mock data
│ └── sample_inputs/ # Tiny mock GWAS files for demonstration
├── README.md # This file
└── .gitignore```

## Source Data
```base_output_folder/
├── eas/
│   └── trait1/
│       └── gwas_results.tsv.gz
├── amr/
│   └── trait1/
│       └── gwas_results.tsv.gz
└── ...```

## Demo
`demo_metal.ipynb` demonstrates how this can be used in the _All of Us_ Researcher Workbench

## License
Released under the MIT License.
