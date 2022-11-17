# Python Protobuf Namespace Package Example

This example demonstrates how to use a namespace package with generated protocol
buffer code. Two actual packages are included: `company.foo` and `company.bar`.
`company` itself is the namespace package.

```
.
├── foo
│   ├── company
│   │   └── foo
│   │       └── __init__.py
│   ├── Makefile
│   └── protos
│       └── company
│           └── foo
│               └── foo.proto
├── bar
│   ├── company
│   │   └── bar
│   │       └── __init__.py
│   ├── Makefile
│   └── protos
│       └── company
│           └── bar
│               └── bar.proto
├── client_pkg
│   ├── client.py
│   └── run_client.sh
```

`foo` and `bar` each represent a separate Python package that will likely be
distributed as a wheel and will likely be hosted in separate source control
repositories. They both use protocol buffers and they both generated code that
will ultimately be imported from the `company` namespace package.

Note that the protobuf package of neither `foo.proto` nor `bar.proto` both reference
start with `company`. This is frequently done so that multiple organizations can
share protos within a single codebase and within a single protobuf source tree.
However, it is often not desirable to let this detail leak into your API and
put the generated code directly under the `company` directory.

To avoid this, we use `_generated_protos` as the top-level generated source path
and reference this path from the hand-written wrapper code in both `foo` and
`bar`:

```python
from _generated_protos.company.foo import foo_pb2
```

As a result, after generation, `foo_pb2.py` ends up at the same path relative
to the generation root (the `--python_out` argument to `protoc`). The same
generation root is used for `--pyi_out` and `--grpc_python_out`, resulting in
the generation of `foo_pb2.pyi` and `foo_pb2_grpc.py` in the same directory.

```
.
├── foo
│   ├── company
│   │   └── foo
│   │       └── __init__.py
│   ├── _generated_protos
│   │   └── company
│   │       └── foo
│   │           ├── foo_pb2_grpc.py
│   │           ├── foo_pb2.py
│   │           └── foo_pb2.pyi
│   ├── Makefile
│   └── protos
│       └── company
│           └── foo
│               └── foo.proto
├── bar
│   ├── company
│   │   └── bar
│   │       └── __init__.py
│   ├── _generated_protos
│   │   └── company
│   │       └── bar
│   │           ├── bar_pb2_grpc.py
│   │           ├── bar_pb2.py
│   │           └── bar_pb2.pyi
│   ├── Makefile
│   └── protos
│       └── company
│           └── bar
│               └── bar.proto
├── client_pkg
│   ├── client.py
│   └── run_client.sh
└── README.md
```

The third top-level directory, `client_pkg` demonstrates a third
repository/wheel that incurs a dependency on both the `foo` package and the
`bar` package.

We use the `PYTHONPATH` environment variable to simulate having installed `foo`
and `bar` as wheels using (e.g.) pip.

```bash
PYTHONPATH=$(realpath ../foo):$(realpath ../bar) python3 client.py
```

This ensures that `company.foo`, `company.bar`, and `_generated_protos` are all
resolveable.
