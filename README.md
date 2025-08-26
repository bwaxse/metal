# METAL Docker Workflow

This repository provides a Dockerized workflow for running **METAL** meta-analysis using SAIGE-formatted GWAS results. It includes a demo Jupyter notebook.

## Repository Structure
```metal/
├── Dockerfile # Dockerfile to build METAL image
├── demo_metal.ipynb # mock Jupyter notebook showing workflow
├── README.md # This file
└── .gitignore
```

## Source Data
```base_output_folder/
├── eas/
│   └── trait1/
│       └── gwas_results.tsv.gz
├── amr/
│   └── trait1/
│       └── gwas_results.tsv.gz
└── ...
```

## License
Released under the MIT License.
