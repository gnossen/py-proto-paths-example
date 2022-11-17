.PHONY: all
all: company/bar/bar_pb2.py company/bar/bar_pb2_grpc.py company/bar/bar_pb2.pyi

company/bar/bar_pb2.py company/bar/bar_pb2.pyi company/bar/bar_pb2_grpc.py: protos/bar/bar.proto
	python3 -m grpc_tools.protoc \
		-I protos \
		--python_out company \
		--grpc_python_out company \
		--pyi_out company \
		"$<"

.PHONY: clean
clean: 
	rm -f company/bar/bar_pb2.py company/bar/bar_pb2_grpc.py company/bar/bar_pb2.pyi
