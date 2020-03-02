docker build -t pal0man3gra/multi-client:latest -t pal0man3gra/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pal0man3gra/multi-server:latest -t pal0man3gra/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pal0man3gra/multi-worker:latest -t pal0man3gra/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push pal0man3gra/multi-client:latest
docker push pal0man3gra/multi-server:latest
docker push pal0man3gra/multi-worker:latest

docker push pal0man3gra/multi-client:$SHA
docker push pal0man3gra/multi-server:$SHA
docker push pal0man3gra/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pal0man3gra/multi-server:$SHA
kubectl set image deployments/client-deployment client=pal0man3gra/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pal0man3gra/multi-worker:$SHA