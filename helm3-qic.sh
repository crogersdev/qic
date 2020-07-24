#!/usr/bin/env bash

CMD=${1:-install} 

TEMPLATE_BASE="$HOME/dev/turtle-deploy/go-helm"
VALUES_BASE="$HOME/orbital/base/values"
KV_SUB_BASE="$HOME/dev"

############################################################################################################################################

helm3 delete user
drop-db -e $KV_SUB_BASE/kv-sub.txt user_service
helm3 "$CMD" user "$TEMPLATE_BASE/user" --namespace=go \
  --values "$TEMPLATE_BASE/user/values.yaml" \
  --values "$VALUES_BASE/user/values-btf.yaml" \
  --set 'ingress.domain=apps.turtle.oi.io' \
  --set 'envs.deployment.OI_USER_CACHE_REDIS=go-ec.turtle.oi.io' \
  --set 'envs.deployment.OI_DBHOST=platform.dev.turtle.oi.io' \
  --set 'envs.deployment.OI_DBPWD=user_service' \
  --set 'envs.deployment.OI_LDAP_SERVER=util1.turtle.oi.io' \
  --set 'envs.deployment.OI_USER_SVC_REST_SERVER=http://api-user.apps.turtle.oi.io' \
  --set 'userService.initDB.enabled=false' \
  --set 'userService.initDB.enabled=false' \
  --set 'image.api.tag=346' \
  --set 'image.admin.tag=346'
helm3 test user

############################################################################################################################################

helm3 delete artifact
drop-db -e $HOME/dev/turtle-deploy/okd-resources/kv-sub.txt artifact_service
helm3 "$CMD" artifact "$TEMPLATE_BASE/artifact" --namespace=go \
  --values "$TEMPLATE_BASE/artifact/values.yaml" \
  --values "$VALUES_BASE/artifact/values-btf.yaml" \
  --set 'ingress.domain=apps.turtle.oi.io' \
  --set 'envs.deployment.OI_DBHOST=platform.dev.turtle.oi.io' \
  --set 'envs.deployment.OI_DBPWD=artifact_service' \
  --set 'envs.deployment.OI_USER_SVC_REST_SERVER=http://api-user.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_ARTIFACT_SVC_REST_SERVER=http://api-artifact.apps.turtle.oi.io' \
  --set 'artifactService.initDB.enabled=false' \
  --set 'artifactService.initDB.enabled=false' \
  --set 'envs.deployment.OI_TOKEN_DEPLOYMENT_TEST=2ccb36c06d3c548ad5d14ae141c26098d751d215' \
  --set 'image.tag=215'
helm3 test artifact

############################################################################################################################################

helm3 delete sam
drop-db -e $HOME/dev/turtle-deploy/okd-resources/kv-sub.txt sam
helm3 "$CMD" sam "$TEMPLATE_BASE/sam" --namespace=go \
  --values "$TEMPLATE_BASE/sam/values.yaml" \
  --values "$VALUES_BASE/sam/values-btf.yaml" \
  --set 'ingress.domain=apps.turtle.oi.io' \
  --set 'envs.deployment.OI_DBHOST=platform.dev.turtle.oi.io' \
  --set 'envs.deployment.OI_DBPWD=sam' \
  --set 'envs.deployment.OI_TILE_SERVICE_DBHOST=platform.dev.turtle.oi.io' \
  --set 'envs.deployment.OI_TILE_SERVICE_DBPWD=tile_service' \
  --set 'envs.deployment.OI_AOI_SVC_REST_SERVER=http://api-aoi.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_TOKEN_DEPLOYMENT_TEST=2ccb36c06d3c548ad5d14ae141c26098d751d215' \
  --set 'envs.deployment.OI_USER_SVC_REST_SERVER=http://api-user.apps.turtle.oi.io' \
  --set 'samService.initDB.enabled=false' \
  --set 'samService.initDB.enabled=false' \
  --set 'image.tag=356'
helm3 test sam

############################################################################################################################################

helm3 "$CMD" visualization "$TEMPLATE_BASE/visualization" --namespace=go \
  --values "$TEMPLATE_BASE/visualization/values.yaml" \
  --values "$VALUES_BASE/visualization/values-btf.yaml" \
  --set 'ingress.domain=apps.turtle.oi.io' \
  --set 'envs.deployment.OI_DBHOST=postgres.turtle.oi.io' \
  --set 'envs.deployment.OI_DBPWD=visualization_service' \
  --set 'envs.deployment.OI_TILE_SERVICE_DBHOST=postgres.turtle.oi.io' \
  --set 'envs.deployment.OI_TILE_SERVICE_DBPWD=tile_service' \
  --set 'envs.deployment.OI_USER_SVC_REST_SERVER=http://api-user.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_VIZ_SVC_REDIS_CACHE_HOST=go-ec.turtle.oi.io' \
  --set 'envs.deployment.OI_VIZ_SVC_REST_SERVER=http://api-visualization.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_MAPBOX_ACCESS_TOKEN=sk.eyJ1Ijoib3JiaXRhbGluc2lnaHQiLCJhIjoiY2pnbzB5ZXhzMmsybzJ4cXE4MzAwZXdwMSJ9.AkHkwcMJMo4-DQO3NiMBEQ' \
  --set 'visualizationService.initDB.enabled=false' \
  --set 'visualizationService.initDB.enabled=false' \
  --set 'envs.deployment.OI_TOKEN_DEPLOYMENT_TEST=2ccb36c06d3c548ad5d14ae141c26098d751d215' \
  --set 'image.tag=258'

############################################################################################################################################

helm3 delete aoi
drop-db -e $HOME/dev/turtle-deploy/okd-resources/kv-sub.txt aoi_service
helm3 "$CMD" aoi "$TEMPLATE_BASE/aoi" --namespace=go \
  --values "$TEMPLATE_BASE/aoi/values.yaml" \
  --values "$VALUES_BASE/aoi/values-btf.yaml" \
  --set 'ingress.domain=apps.turtle.oi.io' \
  --set 'envs.deployment.OI_DBHOST=platform.dev.turtle.oi.io' \
  --set 'envs.deployment.OI_DBPWD=aoi_service' \
  --set 'envs.deployment.OI_RO_DBHOST=platform.dev.turtle.oi.io' \
  --set 'envs.deployment.OI_RO_DBPWD=aoi_service' \
  --set 'envs.deployment.OI_USER_SVC_REST_SERVER=http://api-user.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_AOI_CACHE_REDIS=go-ec.turtle.oi.io' \
  --set 'envs.deployment.OI_AOI_SVC_REST_SERVER=http://api-aoi.apps.turtle.oi.io' \
  --set 'aoiService.initDB.enabled=false' \
  --set 'aoiService.initDB.enabled=false' \
  --set 'envs.deployment.OI_TOKEN_DEPLOYMENT_TEST=2ccb36c06d3c548ad5d14ae141c26098d751d215' \
  --set 'image.tag=242'
helm test aoi

############################################################################################################################################

helm3 delete catalog
drop-db -e $HOME/dev/turtle-deploy/okd-resources/kv-sub.txt catalog_service
helm3 "$CMD" catalog "$TEMPLATE_BASE/catalog" --namespace=go \
  --values "$TEMPLATE_BASE/catalog/values.yaml" \
  --values "$VALUES_BASE/catalog/values-btf.yaml" \
  --set 'ingress.domain=apps.turtle.oi.io' \
  --set 'envs.deployment.OI_DBHOST=platform.dev.turtle.oi.io' \
  --set 'envs.deployment.OI_DBPWD=catalog_service' \
  --set 'envs.deployment.OI_USER_SVC_REST_SERVER=http://api-user.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_AOI_SVC_REST_SERVER=http://api-aoi.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_CATALOG_SVC_REST_SERVER=http://api-catalog.apps.turtle.oi.io' \
  --set 'catalogService.initDB.enabled=false' \
  --set 'catalogService.initDB.enabled=false' \
  --set 'envs.deployment.OI_TOKEN_DEPLOYMENT_TEST=2ccb36c06d3c548ad5d14ae141c26098d751d215' \
  --set 'image.tag=258'
helm test catalog

############################################################################################################################################

helm3 delete mt-portal
helm3 "$CMD" mt-portal "$TEMPLATE_BASE/mt-portal" --namespace=go \
  --values "$TEMPLATE_BASE/mt-portal/values.yaml" \
  --values "$VALUES_BASE/mt-portal/values-btf.yaml" \
  --set 'ingress.domain=apps.turtle.oi.io' \
  --set 'envs.deployment.OI_DBHOST=platform.dev.turtle.oi.io' \
  --set 'envs.deployment.OI_DBPWD=personalization' \
  --set 'envs.deployment.OI_GOCREATE_URL=http://go-services.apps.turtle.oi.io/api/v2/go' \
  --set 'envs.deployment.OI_GOEXPLORE_URL=http://go-services.apps.turtle.oi.io/api/v2/go' \
  --set 'envs.deployment.OI_USER_URL=http://api-user.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_CATALOG_SVC_REST_SERVER=http://api-catalog.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_PORTAL_MT_URL=http://mt.apps.turtle.oi.io' \
  --set 'image.tag=26'

############################################################################################################################################

helm3 "$CMD" project "$TEMPLATE_BASE/project" --namespace=go \
  --values "$TEMPLATE_BASE/project/values.yaml" \
  --values "$VALUES_BASE/project/values-btf.yaml" \
  --set 'projectService.initDB.enabled=false' \
  --set 'projectService.initDB.enabled=false' \
  --set 'ingress.domain=apps.turtle.oi.io' \
  --set 'envs.deployment.OI_DBHOST=postgres.turtle.oi.io' \
  --set 'envs.deployment.OI_DBPWD=project_service' \
  --set 'envs.deployment.OI_RO_DBHOST=postgres.turtle.oi.io' \
  --set 'envs.deployment.OI_RO_DBPWD=project_service' \
  --set 'envs.deployment.OI_USER_SVC_REST_SERVER=http://api-user.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_AOI_SVC_REST_SERVER=http://api-aoi.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_VIZ_SVC_REST_SERVER=http://api-visualization.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_SAM_SVC_REST_SERVER=http://api-sam.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_TOKEN_PROJECT_SERVICE_USER=project_svc_admin' \
  --set 'envs.deployment.OI_TOKEN_PROJECT_SERVICE=2485D98A3CDC1BC454C9ABA9B2930329574A187C' \
  --set 'envs.deployment.OI_PROJECT_SVC_REDIS_CACHE_HOST=go-ec.turtle.oi.io' \
  --set 'image.tag=398'

############################################################################################################################################

helm3 delete go-frontend
helm3 "$CMD" go-frontend "$TEMPLATE_BASE/go-frontend" --namespace=go \
  --values "$TEMPLATE_BASE/go-frontend/values.yaml" \
  --values "$VALUES_BASE/go-frontend/values-btf.yaml" \
  --set 'ingress.domain=apps.turtle.oi.io' \
  --set 'envs.deployment.REACT_APP_OI_USE_EARTH_MONITOR="false"' \
  --set 'envs.deployment.REACT_APP_OI_USE_ONE_ATLAS="false"' \
  --set 'envs.deployment.REACT_APP_OI_GOANALYSIS_API_ENDPOINT=http://go.apps.turtle.oi.io' \
  --set 'envs.deployment.REACT_APP_USER_SERVICE_ENDPOINT=http://api-user.apps.turtle.oi.io' \
  --set 'envs.deployment.REACT_APP_OI_GOEXPLORE_API_ENDPOINT=http://go-services.apps.turtle.oi.io/api/v1/goexplore' \
  --set 'envs.deployment.REACT_APP_OI_GOCREATE_API_ENDPOINT=http://go-services.apps.turtle.oi.io/api/v1/gocreate' \
  --set 'envs.deployment.REACT_APP_OI_GO_API_ENDPOINT_V2=http://go-services.apps.turtle.oi.io/api/v2/go' \
  --set 'envs.deployment.REACT_APP_PORTAL_ENDPOINT=http://mt.apps.turtle.oi.io' 

############################################################################################################################################

helm3 delete notification
drop-db -e $HOME/dev/turtle-deploy/okd-resources/kv-sub.txt notification
helm3 "$CMD" notification "$TEMPLATE_BASE/notification" --namespace=go \
  --values "$TEMPLATE_BASE/notification/values.yaml" \
  --values "$VALUES_BASE/notification/values-btf.yaml" \
  --set 'ingress.domain=apps.turtle.oi.io' \
  --set 'notificationService.initDB.enabled=false' \
  --set 'notificationService.initDB.enabled=false' \
  --set 'envs.deployment.OI_DBHOST=platform.dev.turtle.oi.io' \
  --set 'envs.deployment.OI_DBPWD=notification_service' \
  --set 'envs.deployment.OI_NOTIFY_SVC_REST_SERVER=http://api-notification.apps.turtle.oi.io' \
  --set 'image.tag=136'

helm3 test notification

############################################################################################################################################

helm3 "$CMD" go-services "$TEMPLATE_BASE/go-services" --namespace=go \
  --values "$TEMPLATE_BASE/go-services/values.yaml" \
  --values "$VALUES_BASE/go-services/values-btf.yaml" \
  --set 'ingress.domain=apps.turtle.oi.io' \
  --set 'envs.deployment.OI_SAM_URL=http://api-sam.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_USER_URL=http://api-user.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_PROJECT_SERVICE_URL=http://api-project.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_VISUALIZATION_SERVICE_URL=http://api-visualization.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_NOTIFICATION_URL=http://api-notification.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_AOI_SERVICE_URL=http://api-aoi.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_GOPORTAL_URL=http://go.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_CATALOG_URL=http://api-catalog.apps.turtle.oi.io' \
  --set 'envs.deployment.OI_GOEXPLORE_URL=http://go-services.apps.turtle.oi.io/api/v1/goexplore' \
  --set 'envs.deployment.OI_GOCREATE_URL=http://go-services.apps.turtle.oi.io/api/v1/gocreate' \
  --set 'envs.deployment.OI_TILE_SERVICE_DBPWD=tile_service' \
  --set 'envs.deployment.OI_PROTEUS_VERSION2_DBPWD=proteus' \
  --set 'envs.deployment.OI_PROTEUS_VERSION2_DBNAME=proteus' \
  --set 'envs.deployment.OI_STREAMX_DBPWD=streamx' \
  --set 'envs.deployment.OI_DBPWD=proteus' \
  --set 'envs.deployment.OI_DBNAME=proteus' \
  --set 'envs.deployment.OI_AIRFLOW_DBPWD=airflow' \
  --set 'envs.deployment.OI_DBHOST=postgresturtle.oi.io' \
  --set 'envs.deployment.OI_PROTEUS_VERSION2_DBHOST=postgres.turtle.oi.io' \
  --set 'envs.deployment.OI_STREAMX_DBHOST=postgres.turtle.oi.io' \
  --set 'envs.deployment.OI_AIRFLOW_DBHOST=postgres.dev.turtle.oi.io' \
  --set 'envs.deployment.OI_GOSIGN_KEY=AKIAUZIKTQVX5WJC55FF' \
  --set 'envs.deployment.OI_GOSIGN_SEC=jLVCj+fr8S/WccAPPCMWKmKwKRYsbxnIIjPpXlLM' \
  --set 'envs.deployment.OI_USER_SVC_CACHE_REDIS=go-ec.turtle.oi.io' \
  --set 'envs.deployment.OI_ENV=qic' \
  --set 'image.tag=582'

############################################################################################################################################

helm3 delete go-pipelines
helm3 "$CMD" go-pipelines "$TEMPLATE_BASE/go-pipelines" --namespace=go \
  --values "$TEMPLATE_BASE/go-pipelines/values.yaml" \
  --values "$VALUES_BASE/go-pipelines/values-btf.yaml" \
  --set 'ingress.domain=apps.turtle.oi.io' \
  --set 'envs.streamxConfig.OI_JOB=streamx-controller' \
  --set 'envs.streamxConfig.OI_DBHOST=platform.dev.turtle.oi.io' \
  --set 'envs.streamxConfig.OI_DBUSER=streamx' \
  --set 'envs.streamxConfig.OI_DBPWD=streamx' \
  --set 'envs.streamxConfig.OI_DBNAME=streamx' \
  --set 'envs.streamxConfig.OI_SAM_URL=http://api-sam.apps.turtle.oi.io' \
  --set 'envs.streamxConfig.OI_USER_URL=http://api-user.apps.turtle.oi.io' \
  --set 'envs.streamxConfig.OI_PROJECT_SERVICE_URL=http://api-project.apps.turtle.oi.io' \
  --set 'envs.streamxConfig.OI_VISUALIZATION_SERVICE_URL=http://api-visualization.apps.turtle.oi.io' \
  --set 'envs.streamxConfig.OI_NOTIFICATION_URL=http://api-notification.apps.turtle.oi.io' \
  --set 'envs.streamxConfig.OI_ORDERING_INGESTION_DBHOST=platform.dev.turtle.oi.io' \
  --set 'envs.streamxConfig.OI_ORDERING_INGESTION_DBPWD=' \
  --set 'envs.streamxConfig.OI_AOI_SERVICE_URL=http://api-aoi.apps.turtle.oi.io' \
  --set 'envs.streamxConfig.OI_GOPORTAL_URL=http://go.apps.turtle.oi.io' \
  --set 'envs.streamxConfig.OI_CATALOG_URL=http://api-catalog.apps.turtle.oi.io' \
  --set 'envs.streamxConfig.OI_GOEXPLORE_URL=http://go-services.apps.turtle.oi.io/api/v1/goexplore' \
  --set 'envs.streamxConfig.OI_GOCREATE_URL=http://go-services.apps.turtle.oi.io/api/v1/gocreate' \
  --set 'envs.streamxConfig.OI_TILE_SERVICE_DBPWD=tile_service' \
  --set 'envs.streamxConfig.OI_PROTEUS_VERSION2_DBPWD=proteus' \
  --set 'envs.streamxConfig.OI_STREAMX_DBPWD=streamx' \
  --set 'envs.streamxConfig.OI_STREAMX_DBUSER=streamx' \
  --set 'envs.streamxConfig.OI_STREAMX_DBNAME=streamx' \
  --set 'envs.streamxConfig.OI_DBHOST=platform.dev.turtle.oi.io' \
  --set 'envs.streamxConfig.OI_PROTEUS_VERSION2_DBHOST=platform.dev.turtle.oi.io' \
  --set 'envs.streamxConfig.OI_STREAMX_DBHOST=platform.dev.turtle.oi.io' \
  --set 'envs.streamxConfig.OI_GOSIGN_KEY=AKIAUZIKTQVX5WJC55FF' \
  --set 'envs.streamxConfig.OI_GOSIGN_SEC=jLVCj+fr8S/WccAPPCMWKmKwKRYsbxnIIjPpXlLM' \
  --set 'envs.streamxConfig.OI_USER_SVC_CACHE_REDIS=go-ec.turtle.oi.io' \
  --set 'envs.streamxConfig.OI_TILE_SERVICE_DBHOST=platform.dev.turtle.oi.io' \
  --set 'envs.streamxConfig.OI_TILE_SERVICE_DBPWD=tile_service' \
  --set 'envs.streamxConfig.OI_TILE_SERVICE_PROD_DBHOST=platform.dev.turtle.oi.io' \
  --set 'envs.streamxConfig.OI_TILE_SERVICE_PROD_DBPWD=tile_service'

############################################################################################################################################

helm3 "$CMD" streamx-controller "$TEMPLATE_BASE/streamx-controller" --namespace=go \
  --values "$TEMPLATE_BASE/streamx-controller/values.yaml" \
  --values "$VALUES_BASE/streamx-controller/values-btf.yaml" \
  --set 'envs.controller.OI_JOB=streamx-controller' \
  --set 'envs.controller.OI_DBHOST=postgres.turtle.oi.io' \
  --set 'envs.controller.OI_DBUSER=streamx' \
  --set 'envs.controller.OI_DBPWD=streamx' \
  --set 'envs.controller.OI_DBNAME=streamx' \
  --set 'envs.controller.OI_SAM_URL=http://api-sam.apps.turtle.oi.io' \
  --set 'envs.controller.OI_USER_URL=http://api-user.apps.turtle.oi.io' \
  --set 'envs.controller.OI_PROJECT_SERVICE_URL=http://api-project.apps.turtle.oi.io' \
  --set 'envs.controller.OI_VISUALIZATION_SERVICE_URL=http://api-visualization.apps.turtle.oi.io' \
  --set 'envs.controller.OI_NOTIFICATION_URL=http://api-notification.apps.turtle.oi.io' \
  --set 'envs.controller.OI_ORDERING_INGESTION_DBHOST=postgres.turtle.oi.io' \
  --set 'envs.controller.OI_ORDERING_INGESTION_DBNAME=ordering_ingestion' \
  --set 'envs.controller.OI_ORDERING_INGESTION_DBUSER=ordering_ingestion' \
  --set 'envs.controller.OI_ORDERING_INGESTION_DBPWD=ordering_ingestion' \
  --set 'envs.controller.OI_AOI_SERVICE_URL=http://api-aoi.apps.turtle.oi.io' \
  --set 'envs.controller.OI_GOPORTAL_URL=http://go.apps.turtle.oi.io' \
  --set 'envs.controller.OI_CATALOG_URL=http://api-catalog.apps.turtle.oi.io' \
  --set 'envs.controller.OI_CATALOG_SVC_REST_SERVER=http://api-catalog.apps.turtle.oi.io' \
  --set 'envs.controller.OI_CATALOG_PROD_URL=http://api-catalog.apps.turtle.oi.io' \
  --set 'envs.controller.OI_GOEXPLORE_URL=http://go-services.apps.turtle.oi.io/api/v1/goexplore' \
  --set 'envs.controller.OI_GOCREATE_URL=http://go-services.apps.turtle.oi.io/api/v1/gocreate' \
  --set 'envs.controller.OI_TILE_SERVICE_DBPWD=tile_service' \
  --set 'envs.controller.OI_PROTEUS_VERSION2_DBPWD=proteus' \
  --set 'envs.controller.OI_PROTEUS_VERSION2_DBUSER=proteus' \
  --set 'envs.controller.OI_PROTEUS_VERSION2_DBNAME=proteus' \
  --set 'envs.controller.OI_PROTEUS_VERSION2_DBHOST=postgres.turtle.oi.io' \
  --set 'envs.controller.OI_STREAMX_DBPWD=streamx' \
  --set 'envs.controller.OI_STREAMX_DBUSER=streamx' \
  --set 'envs.controller.OI_STREAMX_DBNAME=streamx' \
  --set 'envs.controller.OI_DBHOST=postgres.turtle.oi.io' \
  --set 'envs.controller.OI_STREAMX_DBHOST=postgres.turtle.oi.io' \
  --set 'envs.controller.OI_GOSIGN_KEY=AKIAUZIKTQVX5WJC55FF' \
  --set 'envs.controller.OI_GOSIGN_SEC=jLVCj+fr8S/WccAPPCMWKmKwKRYsbxnIIjPpXlLM' \
  --set 'envs.controller.OI_USER_SVC_CACHE_REDIS=go-ec.turtle.oi.io' \
  --set 'envs.controller.OI_TILE_SERVICE_DBHOST=postgres.turtle.oi.io' \
  --set 'envs.controller.OI_TILE_SERVICE_DBPWD=tile_service' \
  --set 'envs.controller.OI_TILE_SERVICE_DBUSER=tile_service' \
  --set 'envs.controller.OI_TILE_SERVICE_DBNAME=tile_service' \
  --set 'envs.controller.OI_TILE_SERVICE_PROD_DBHOST=postgres.turtle.oi.io' \
  --set 'envs.controller.OI_TILE_SERVICE_PROD_DBPWD=tile_service' \
  --set 'envs.controller.OI_TILE_SERVICE_PROD_DBUSER=tile_service' \
  --set 'envs.controller.OI_TILE_SERVICE_PROD_DBUSER=tile_service' \
  --set 'envs.controller.KERAS_BACKEND=tensorflow' \
  --set 'envs.controller.OI_ENV=qic' \
  --set 'envs.decider.OI_DBHOST=postgres.turtle.oi.io' \
  --set 'envs.decider.OI_DBUSER=proteus' \
  --set 'envs.decider.OI_DBPWD=proteus' \
  --set 'envs.decider.OI_DBNAME=proteus' \
  --set 'envs.decider.OI_SAM_URL=http://api-sam.apps.turtle.oi.io' \
  --set 'envs.decider.OI_USER_URL=http://api-user.apps.turtle.oi.io' \
  --set 'envs.decider.OI_PROJECT_SERVICE_URL=http://api-project.apps.turtle.oi.io' \
  --set 'envs.decider.OI_VISUALIZATION_SERVICE_URL=http://api-visualization.apps.turtle.oi.io' \
  --set 'envs.decider.OI_NOTIFICATION_URL=http://api-notification.apps.turtle.oi.io' \
  --set 'envs.decider.OI_ORDERING_INGESTION_DBHOST=postgres.turtle.oi.io' \
  --set 'envs.decider.OI_ORDERING_INGESTION_DBUSER=ordering_ingestion' \
  --set 'envs.decider.OI_ORDERING_INGESTION_DBPWD=ordering_ingestion' \
  --set 'envs.decider.OI_ORDERING_INGESTION_DBNAME=ordering_ingestion' \
  --set 'envs.decider.OI_AOI_SERVICE_URL=http://api-aoi.apps.turtle.oi.io' \
  --set 'envs.decider.OI_GOPORTAL_URL=http://go.apps.turtle.oi.io' \
  --set 'envs.decider.OI_CATALOG_URL=http://api-catalog.apps.turtle.oi.io' \
  --set 'envs.decider.OI_CATALOG_SVC_REST_SERVER=http://api-catalog.apps.turtle.oi.io' \
  --set 'envs.decider.OI_CATALOG_PROD_URL=http://api-catalog.apps.turtle.oi.io' \
  --set 'envs.decider.OI_GOEXPLORE_URL=http://go-services.apps.turtle.oi.io/api/v1/goexplore' \
  --set 'envs.decider.OI_GOCREATE_URL=http://go-services.apps.turtle.oi.io/api/v1/gocreate' \
  --set 'envs.decider.OI_TILE_SERVICE_DBPWD=tile_service' \
  --set 'envs.decider.OI_PROTEUS_VERSION2_DBPWD=proteus' \
  --set 'envs.decider.OI_PROTEUS_VERSION2_DBUSER=proteus' \
  --set 'envs.decider.OI_PROTEUS_VERSION2_DBNAME=proteus' \
  --set 'envs.decider.OI_PROTEUS_VERSION2_DBHOST=postgres.turtle.oi.io' \
  --set 'envs.decider.OI_STREAMX_DBPWD=streamx' \
  --set 'envs.decider.OI_STREAMX_DBUSER=streamx' \
  --set 'envs.decider.OI_STREAMX_DBNAME=streamx' \
  --set 'envs.decider.OI_DBHOST=postgres.turtle.oi.io' \
  --set 'envs.decider.OI_STREAMX_DBHOST=postgres.turtle.oi.io' \
  --set 'envs.decider.OI_GOSIGN_KEY=AKIAUZIKTQVX5WJC55FF' \
  --set 'envs.decider.OI_GOSIGN_SEC=jLVCj+fr8S/WccAPPCMWKmKwKRYsbxnIIjPpXlLM' \
  --set 'envs.decider.OI_USER_SVC_CACHE_REDIS=go-ec.turtle.oi.io' \
  --set 'envs.decider.OI_TILE_SERVICE_DBHOST=postgres.turtle.oi.io' \
  --set 'envs.decider.OI_TILE_SERVICE_DBUSER=tile_service' \
  --set 'envs.decider.OI_TILE_SERVICE_DBPWD=tile_service' \
  --set 'envs.decider.OI_TILE_SERVICE_DBNAME=tile_service' \
  --set 'envs.decider.OI_TILE_SERVICE_DEV_DBHOST=postgres.turtle.oi.io' \
  --set 'envs.decider.OI_TILE_SERVICE_PROD_DBPWD=tile_service' \
  --set 'envs.decider.OI_TILE_SERVICE_PROD_DBUSER=tile_service' \
  --set 'envs.decider.OI_TILE_SERVICE_PROD_DBNAME=tile_service' \
  --set 'envs.decider.S3_ORBITAL_SCENES=combine-orbital-scenes' \
  --set 'envs.decider.S3_ORBITAL_SCENES_PROD=combine-orbital-scenes' \
  --set 'envs.decider.S3_ORBITAL_TILES_PROD=combine-orbital-tiles' \
  --set 'envs.decider.S3_ORBITAL_TILES=combine-orbital-tiles' \
  --set 'envs.decider.S3_TILE_SERVICE_PROD_TILES=combine-orbital-tiles' \
  --set 'envs.decider.S3_TILE_SERVICE_TILES=combine-orbital-tiles' \
  --set 'envs.decider.S3_RUNTIME=combine-runtime-prod' \
  --set 'envs.decider.S3_REQUEST_BUCKET=combine-runtime-prod' \
  --set 'envs.decider.S3_BUCKET=combine-runtime-prod' \
  --set 'envs.decider.S3_ASTRIUM_REQUEST_BUCKET=combine-runtime-prod' \
  --set 'envs.decider.KERAS_BACKEND=tensorflow' \
  --set 'envs.decider.OI_ENV=qic' \
  --set 'image.tag=42'
