#!/usr/bin/env bash

set -euo pipefail

main() {
	docker build -t gcr.io/mobius-network/hello-app:${REVISION} .
	gcloud docker -- push gcr.io/mobius-network/hello-app:${REVISION}

	sed 's/__REVISION__/'"$REVISION"'/g' < manifests/helloweb-deployment.yaml > manifests/helloweb-deployment.yaml

	cat manifests/helloweb-deployment.yaml

	kubectl apply -f manifests/helloweb-deployment.yaml
	kubectl apply -f manifests/helloweb-service.yaml

	kubectl get pods
}

main "$@"
