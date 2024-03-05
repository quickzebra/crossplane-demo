# The is a demo for App of Apps + Crossplane

### Please Note: the following is draft demo flow and it will further automated in the near future

### Break the carts application
Run the following script:
```
breakCarts.sh
```
Carts old app is deployed on ARGO CD, We need to move to carts app that utilises crossplane created external dynamo db
Replace carts-old with carts and add or uncomment crossplane-dynamodb in values.yaml in the app-of-apps dir and push changes to your repo
after running the above commands as a script

### Fix the carts application

Broken carts App is deployed in Argo
Following script will fix the iam policy composition and then delete and recreate the whole app of apps setup
Make sure $GITOPS_REPO_URL_ARGOCD has been setup as your git repo and you are logged in to argocd via ui if not then use the following command

```bash
argocd login $(kubectl get svc argo-cd-argocd-server -n argocd -o json | jq --raw-output '.status.loadBalancer.ingress[0].hostname') --username admin --password $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d) --insecure
```

```
fixCarts.sh
```