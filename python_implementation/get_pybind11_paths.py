import pybind11
import sysconfig

print(pybind11.get_include())
print(sysconfig.get_paths()['include'])
