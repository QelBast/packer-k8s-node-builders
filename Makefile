ubuntu:
	cd ubuntu
	packer init .
	packer validate -var-file="variables.auto.pkrvars.hcl" .
	packer build -color=true -force -timestamp-ui -var-file="variables.auto.pkrvars.hcl" .