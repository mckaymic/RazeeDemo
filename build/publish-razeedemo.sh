#!/bin/bash
################################################################################
# Copyright 2019 IBM Corp. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################
set -e

THIS_DIR=$(dirname "${BASH_SOURCE[0]}")

docker push "mckaymic/razeedemo:${TRAVIS_COMMIT}"
aws s3 --endpoint-url "${COS_ENDPOINT}"  cp "/tmp/razeedemo/resource.yaml" "s3://${BUCKET}/tmp/razeedemo/${TRAVIS_COMMIT}/resource.yaml" --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers

"${THIS_DIR}/publish-variant.sh"
