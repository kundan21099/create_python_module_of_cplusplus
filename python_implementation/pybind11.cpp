#include <CPlusPlusClass.h>
#include <pybind11/pybind11.h>

namespace py = pybind11;

PYBIND11_MODULE(CPlusPlusClass, m) {
    m.doc() = "Dummy C++ module using pybind11";

    py::class_<CPlusPlusClass>(m, "CPlusPlusClass")
        .def(py::init<int, int>())
        .def("addition", &CPlusPlusClass::addition);
}
