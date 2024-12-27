PLAN_PREFIX = plan

# - 
# S3
# -
plan: 
	terraform plan --out ${PLAN_PREFIX}_$(NAME)

apply: run clear-plans 
run: 
	terraform apply ${PLAN_PREFIX}_$(NAME)


# -
# Helpers
# - 
clear-plans:
	rm plan_*

.PHONY: clear-plans plan apply run import-cloud-buckets