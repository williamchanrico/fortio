#!/usr/bin/env bash

# This entrypoint will wait for istio-proxy to be available

if [ "$WAIT_FOR_ISTIO_SIDECAR" = true ]; then
	echo Waiting for Sidecar

	count=30
	until curl -I localhost:15000; do
		echo Still waiting...
		count=$((count - 1))
		sleep 2

		if [ $count -lt 0 ]; then
			echo "Bypassing sidecar check, took too long (60s++)"
			break
		fi
	done
fi

echo Starting fortio "$@" in 10s
sleep 10
/usr/bin/fortio "$@"
