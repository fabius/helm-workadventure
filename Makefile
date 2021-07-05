.PHONY: up
up:
	# cert-manager has to be a separate step because or the CRDs it creates
	helm repo add jetstack https://charts.jetstack.io
	helm repo update
	helm upgrade --install cert-manager jetstack/cert-manager --version v1.4.0 --set installCRDs=true
	sleep 10
	helm upgrade --install workadventure-jitsi .

.PHONY: down
down:
	# take down releases
	helm delete workadventure-jitsi | true
	helm delete cert-manager | true
	# repo cleanup
	helm repo rm jetstack | true
