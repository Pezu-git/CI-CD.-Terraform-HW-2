# "Подъём инфраструктуры в Yandex Cloud"

`Последовательность вызова команд`

1. `terraform apply - Создание ВМ terraform1`

![terraform apply](https://github.com/Pezu-git/CI-CD.-Terraform-HW-2/blob/main/img/tarraformapply.png)

2. `yc compute instance list - Вывод списка существующих ВМ`

![vm list](https://github.com/Pezu-git/CI-CD.-Terraform-HW-2/blob/main/img/vmlist.png)

3. `ansible-playbook -i inventory playbooks/install_nginx.yml - Установка nginx на хосты, указанные в файле inventory`

![ansible install nginx](https://github.com/Pezu-git/CI-CD.-Terraform-HW-2/blob/main/img/installnginx.png)

4. `ansible-playbook -i inventory playbooks/checknginx.yml - Проверка статуса и версии nginx на ВМ terraform1`

![ansible check nginx](https://github.com/Pezu-git/CI-CD.-Terraform-HW-2/blob/main/img/checknginx.png)



