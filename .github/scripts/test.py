import os
import grpc
import json
import requests
import math
import logging
import argparse
import yaml
import random
import time
import string
from typing import Optional
from github import Github, Auth as GithubAuth
from yandexcloud import (
    SDK,
    RetryInterceptor,
    backoff_linear_with_jitter
)
from yandexcloud._operation_waiter import wait_for_operation
from yandex.cloud.compute.v1.instance_service_pb2_grpc import InstanceServiceStub
from yandex.cloud.compute.v1.instance_pb2 import Instance
from yandex.cloud.compute.v1.instance_service_pb2 import (
    CreateInstanceRequest,
    ResourcesSpec,
    AttachedDiskSpec,
    NetworkInterfaceSpec,
    PrimaryAddressSpec,
    OneToOneNatSpec,
    DeleteInstanceRequest,
    CreateInstanceMetadata,
    DeleteInstanceMetadata,
    GetInstanceSerialPortOutputRequest,
    GetInstanceSerialPortOutputResponse

)
from yandex.cloud.compute.v1.instance_pb2 import IpVersion


logging.basicConfig(
    level=logging.INFO, format="%(asctime)s: %(levelname)s: %(message)s"
)

logger = logging.getLogger(__name__)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest="action", help="Action to perform")
    parser.add_argument(
        "--api-endpoint",
        default="api.ai.nebius.cloud",
        help="Cloud API Endpoint",
    )

    parser.add_argument(
        "--service-account-key",
        required=True,
        help="Path to the service account key file",
    )
    parser.add_argument("--id", default="", help="VM id")

    parser.add_argument("--retry-time", default=10, help="How often to retry (seconds)")
    parser.add_argument(
        "--timeout", default=1200, help="How long to wait for creation (seconds)"
    )

    args = parser.parse_args()

    interceptor = RetryInterceptor(
        max_retry_count=args.timeout / args.retry_time,
        retriable_codes=[grpc.StatusCode.UNAVAILABLE],
        back_off_func=backoff_linear_with_jitter(args.retry_time, 0),
    )

    with open(args.service_account_key, "r") as fp:
        sdk = SDK(
            service_account_key=json.load(fp),
            endpoint=args.api_endpoint,
            interceptor=interceptor,
        )

    instance_service = sdk.client(InstanceServiceStub)

    result_serial = instance_service.GetSerialPortOutput(
        GetInstanceSerialPortOutputRequest(
            instance_id=args.id
        )
    )
    print(result_serial.contents)
    with open(f"console_output.txt", "w") as f:
        f.write(result_serial.contents)
