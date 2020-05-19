docker build -t nunoaleixogoncalves/multi-client:latest -t nunoaleixogoncalves/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nunoaleixogoncalves/multi-server:latest -t nunoaleixogoncalves/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nunoaleixogoncalves/multi-worker:latest -t nunoaleixogoncalves/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nunoaleixogoncalves/multi-client:latest
docker push nunoaleixogoncalves/multi-client:$SHA
docker push nunoaleixogoncalves/multi-server:latest
docker push nunoaleixogoncalves/multi-server:$SHA
docker push nunoaleixogoncalves/multi-worker:latest
docker push nunoaleixogoncalves/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nunoaleixogoncalves/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=nunoaleixogoncalves/multi-worker:$SHA
kubectl set image deployments/client-deployment client=nunoaleixogoncalves/multi-client:$SHA