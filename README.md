### Create Python Module of the C++ Code / Class

***Prerequisite***
- Python
- Pybind11 module
- Eclipse or any other compiler
- MingW64

***Project Structure***

![Alt text](./images/project_structure.jpg?raw=true "project_structure")

Above image shows the the structure.

- **build:** This folder is used to create the object files. (used in g++ commands)
- **python_implementation:** In this folder the dynamic python module will be created based on commands. 

***1. install pybind11 library***
***2. Activate venv***
***3. Run the .bat file to create .pyd module***