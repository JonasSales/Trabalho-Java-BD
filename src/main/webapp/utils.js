export function mascaraCPF(input) {
    let cpf = input.value;
    // Remove tudo que não for número
    cpf = cpf.replace(/\D/g, "");
    // Adiciona pontos e traço conforme o tamanho
    cpf = cpf.replace(/^(\d{3})(\d)/, "$1.$2");
    cpf = cpf.replace(/^(\d{3})\.(\d{3})(\d)/, "$1.$2.$3");
    cpf = cpf.replace(/\.(\d{3})(\d{1,2})$/, ".$1-$2");
    // Atualiza o valor no campo
    input.value = cpf;
}

export function mascaraSalario(input) {
    let salario = input.value;
    salario = salario.replace(/\D/g, "");

    if (salario.length > 2) {
        salario = salario.replace(/(\d+)(\d{2})$/, "$1.$2");
    } else if (salario.length < 2) {
        salario = "." + salario;
    }
    input.value = salario;
}

export function mascaraDimensoes(input) {
    let dimensoes = input.value;
    // Remove tudo que não for número
    dimensoes = dimensoes.replace(/\D/g, "");
    // Adiciona pontos e traço conforme o tamanho
    dimensoes = dimensoes.replace(/^(\d{2})(\d)/, "$1x$2");
    dimensoes = dimensoes.replace(/^(\d{2})\x(\d{2})(\d)/, "$1x$2x$3");
    dimensoes = dimensoes.replace(/\x(\d{2})(\d{1,2,3})$/, ".$1x$2x$3");
    // Atualiza o valor no campo
    input.value = dimensoes;
}


export function redirecionar(endereco, tempo = 5000) {
    setTimeout(function () {
        window.location.href = endereco;
    }, tempo); // Redireciona após o tempo especificado (5000 ms por padrão)
}

export function reloadPage() {
    location.reload();  // Recarrega a página
}

export function mascaraCNPJ(input) {
    let cnpj = input.value;
    cnpj = cnpj.replace(/[^a-zA-Z0-9]/g, '');
    cnpj = cnpj.replace(/^([a-zA-Z0-9]{2})([a-zA-Z0-9])/, "$1.$2");
    cnpj = cnpj.replace(/^([a-zA-Z0-9]{2})\.([a-zA-Z0-9]{3})([a-zA-Z0-9])/, "$1.$2.$3");
    cnpj = cnpj.replace(/\.([a-zA-Z0-9]{3})([a-zA-Z0-9])/, ".$1/$2");
    cnpj = cnpj.replace(/([a-zA-Z0-9]{4})(\d{2})$/, "$1-$2");

    input.value = cnpj;
}
