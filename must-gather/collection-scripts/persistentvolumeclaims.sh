#!/bin/bash
resource="persistentvolumeclaims"

base_collection_path=$1
namespace=$2
if [ "${base_collection_path}" = "" ];then
    echo "Base collection path for ${resource} is not passed. Exiting."
    exit 0
fi

if [ "${namespace}" = "" ];then
    echo "Namespace for ${resource} is not passed. Exiting."
    exit 0
fi

# removing previous collector files
rm -rf collector.sh

echo " -> Fetching dump of persistentvolumeclaims"

api_group="core"
if [ "${api_group}" != "" ]; then 
    base_collection_path="${base_collection_path}/${api_group}"
fi

base_collection_path="${base_collection_path}/${resource}"
mkdir -p "${base_collection_path}"
timeout 120 oc get ${resource} -n "${namespace}" -o yaml > "${base_collection_path}"/${resource}.yaml 2>&1
