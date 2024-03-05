<<EOF
Carts old app is deployed on ARGO CD, We need to move to carts app 
Replace carts-old from values.yaml in the app-of-apps dir
then run the below commands
EOF
#### Break Carts app ####

kubectl apply -k crossplane/broken-iam-policy

echo y | argocd app delete crossplane-dynamodb

