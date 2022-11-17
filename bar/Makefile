PROTO_SRC_ROOT=protos
PROTO_GEN_ROOT=_generated_protos

.PHONY: all
all: ${PROTO_GEN_ROOT}/company/bar/bar_pb2.py ${PROTO_GEN_ROOT}/company/bar/bar_pb2_grpc.py ${PROTO_GEN_ROOT}/company/bar/bar_pb2.pyi

${PROTO_GEN_ROOT}/company/bar/bar_pb2.py ${PROTO_GEN_ROOT}/company/bar/bar_pb2_grpc.py ${PROTO_GEN_ROOT}/company/bar/bar_pb2.pyi: ${PROTO_SRC_ROOT}/company/bar/bar.proto
	mkdir -p ${PROTO_GEN_ROOT}
	python3 -m grpc_tools.protoc \
		-I ${PROTO_SRC_ROOT} \
		--python_out ${PROTO_GEN_ROOT} \
		--grpc_python_out ${PROTO_GEN_ROOT} \
		--pyi_out ${PROTO_GEN_ROOT} \
		"$<"

.PHONY: clean
clean: 
	rm -f ${PROTO_GEN_ROOT}/company/bar/bar_pb2.py ${PROTO_GEN_ROOT}/company/bar/bar_pb2_grpc.py ${PROTO_GEN_ROOT}/company/bar/bar_pb2.pyi
