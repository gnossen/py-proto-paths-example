# Python Protobuf Namespace Package Example

This example demonstrates how to use a namespace package with generated protocol
buffer code. Two actual packages are included: `company.foo` and `company.bar`.
`company` itself is the namespace package.

```
.
├── foo
│   ├── Makefile
│   └── protos
│       └── foo
│           └── foo.proto
├── bar
│   ├── Makefile
│   └── protos
│       └── bar
│           └── bar.proto
├── client_pkg
│   ├── client.py
│   └── run_client.sh
```

`foo` and `bar` each represent a separate Python package that will likely be
distributed as a wheel and will likely be hosted in separate source control
repositories. They both use protocol buffers and they both generated code that
will ultimately be imported from the `company` namespace package.

Note that the protobuf package of neither `foo.proto` nor `bar.proto` references
the `company` namespace package. The package for `foo.proto` is simply `foo`.
This matches its path relative to the proto root for the `foo` package
(`foo/protos`). It is best practice to ensure that all proto files' packages
mirror their directory structure relative to the proto root that they are being
compiled against (the `-I` flag to `protoc`).

As a result, after generation, `foo_pb2.py` ends up at the same path relative
to the generation root (the `--python_out` argument to `protoc`). The same
generation root is used for `--pyi_out` and `--grpc_python_out`, resulting in
the generation of `foo_pb2.pyi` and `foo_pb2_grpc.py` in the same directory.

```
.
├── foo
│   ├── company
│   │   └── foo
│   │       ├── foo_pb2_grpc.py
│   │       ├── foo_pb2.py
│   │       └── foo_pb2.pyi
│   ├── Makefile
│   └── protos
│       └── foo
│           └── foo.proto
├── bar
│   ├── company
│   │   └── bar
│   │       ├── bar_pb2_grpc.py
│   │       ├── bar_pb2.py
│   │       └── bar_pb2.pyi
│   ├── Makefile
│   └── protos
│       └── bar
│           └── bar.proto
├── client_pkg
│   ├── client.py
│   └── run_client.sh
```

The third top-level directory, `client_pkg` demonstrates a third
repository/wheel that incurs a dependency on both the `foo` package and the
`bar` package.

We use the `PYTHONPATH` environment variable to simulate having installed `foo`
and `bar` as wheels using (e.g.) pip.

```bash
PYTHONPATH=$(realpath ../foo):$(realpath ../bar) python3 client.py
```
