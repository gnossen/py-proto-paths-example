.PHONY: all
all: company/foo/foo_pb2.py company/foo/foo_pb2_grpc.py company/foo/foo_pb2.pyi

company/foo/foo_pb2.py company/foo/foo_pb2.pyi company/foo/foo_pb2_grpc.py: protos/foo/foo.proto
	python3 -m grpc_tools.protoc \
		-I protos \
		--python_out company \
		--grpc_python_out company \
		--pyi_out company \
		"$<"

.PHONY: clean
clean: 
	rm -f company/foo/foo_pb2.py company/foo/foo_pb2_grpc.py company/foo/foo_pb2.pyi
