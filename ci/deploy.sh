#!/usr/bin/env bash

set -euo pipefail

main() {
	gcloud docker -- pull gcr.io/mobius-network/hello-app:latest
	docker build -t gcr.io/mobius-network/hello-app:latest .
	gcloud docker -- push gcr.io/mobius-network/hello-app:latest

	kubectl apply -f manifests/helloweb-deployment.yaml
	kubectl apply -f manifests/helloweb-service.yaml

	kubectl get pods
}

main "$@"
