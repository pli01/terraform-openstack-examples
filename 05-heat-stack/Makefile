TF_BIN = ../terraform
TF_APPLY_ARGS = -auto-approve
TF_DESTROY_ARGS = -auto-approve
export

deploy: validate plan apply

format:
	${TF_BIN} fmt -check || ${TF_BIN} fmt -diff
validate:
	${TF_BIN} validate
plan:
	${TF_BIN} plan
apply:
	${TF_BIN} apply ${TF_APPLY_ARGS}
destroy:
	${TF_BIN} destroy ${TF_DESTROY_ARGS} -target=openstack_orchestration_stack_v1.stack_1
