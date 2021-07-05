SHELL := bash

.PHONY: up
up:
	# cert-manager deployment has to be a separate step because of the CRDs it creates.
	# Technically, one could put those CRDs in a "crds" directory, however
	# these cannot be upgraded / managed by helm further down the line.
	# Thus, keeping them in a separate chart feels like a sensible choice.
	# Read on: https://helm.sh/docs/chart_best_practices/custom_resource_definitions/#method-2-separate-charts
	helm repo add jetstack https://charts.jetstack.io
	helm repo update
	helm upgrade --install cert-manager jetstack/cert-manager --version v1.4.0 --set installCRDs=true
	until kubectl rollout status deployments/cert-manager-webhook ; do \
	    sleep 1 ; \
	done
	@echo waiting for the CA injection to take place
	sleep 30
	
	# Deploy the applications themselves
	helm upgrade --install workadventure-jitsi .
	@echo
	@echo "The sites will be publicly available once the certificates have been rolled out."
	@echo "To track the certificate rollout, run"
	@echo "  kubectl get -w certificates"

.PHONY: down
down:
	# Take down releases
	helm delete workadventure-jitsi | true
	helm delete cert-manager | true
	# Repo cleanup
	helm repo rm jetstack | true
