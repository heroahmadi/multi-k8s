docker build -t heroahmadi/multi-client:latest -t heroahmadi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t heroahmadi/multi-server:latest -t heroahmadi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t heroahmadi/multi-worker:latest -t heroahmadi/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push heroahmadi/multi-client:latest
docker push heroahmadi/multi-client:$SHA
docker push heroahmadi/multi-server:latest
docker push heroahmadi/multi-server:$SHA
docker push heroahmadi/multi-worker:latest
docker push heroahmadi/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment server=heroahmadi/multi-client:$SHA
kubectl set image deployments/server-deployment server=heroahmadi/multi-server:$SHA
kubectl set image deployments/worker-deployment server=heroahmadi/multi-worker:$SHA