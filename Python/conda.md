# conda

1. 创建并激活一个环境

    ```
    conda create -n env_name python=3.6
    ```

2. 显示所有的虚拟环境

    ```
    conda info --envs
    ```

3. 修改环境名称

    ```
    conda --create <new_name> --clone <old_name>
    ```