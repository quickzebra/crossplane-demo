<<EOF
Broken carts App is deployed in Argo
Following script will fix the iam policy composition and then delete and recreate the whole app of apps setup
Make sure $GITOPS_REPO_URL_ARGOCD has been setup as your git repo
EOF
#### Break Carts app ####

kubectl apply -k crossplane/fix-iam-policy

echo y | argocd app delete apps


argocd app create apps --repo $GITOPS_REPO_URL_ARGOCD --dest-server https://kubernetes.default.svc --sync-policy automated --self-heal --auto-prune --set-finalizer --upsert --path app-of-apps
