#!/usr/bin/env bash

set -euo pipefail

main() {
	docker build -t gcr.io/mobius-network/hello-app:${REVISION} .
	gcloud docker -- push gcr.io/mobius-network/hello-app:${REVISION}

	cat manifests/helloweb-deployment.yaml | sed 's/__REVISION__/'"$REVISION"'/g' > manifests/helloweb-deployment-r.yaml

	cat manifests/helloweb-deployment-r.yaml

	kubectl apply -f manifests/helloweb-deployment-r.yaml
	kubectl apply -f manifests/helloweb-service.yaml

	kubectl get pods
}

main "$@"
