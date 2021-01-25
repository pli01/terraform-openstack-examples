TERRAFORM_BIN = ../terraform

deploy: validate plan apply

validate:
	$(TERRAFORM_BIN) validate
plan:
	$(TERRAFORM_BIN) plan
apply:
	$(TERRAFORM_BIN) apply -auto-approve
destroy:
	$(TERRAFORM_BIN) destroy -target=openstack_orchestration_stack_v1.stack_1 -auto-approve
