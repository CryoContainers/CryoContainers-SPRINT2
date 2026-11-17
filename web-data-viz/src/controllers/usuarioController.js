var usuarioModel = require("../models/usuarioModel");

function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (!email) {
        res.status(400).send("Seu email está undefined!");
    } else if (!senha) {
        res.status(400).send("Sua senha está indefinida!");
    } else {

        usuarioModel.autenticar(email, senha)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);

                    if (resultadoAutenticar.length == 1) {
                        // A senha NÃO é devolvida para o navegador
                        res.json({
                            id: resultadoAutenticar[0].id,
                            nome: resultadoAutenticar[0].nome,
                            email: resultadoAutenticar[0].email,
                            cpf: resultadoAutenticar[0].cpf,
                            telefone: resultadoAutenticar[0].telefone,
                            dt_cadastro: resultadoAutenticar[0].dt_cadastro,
                            fkEmpresa: resultadoAutenticar[0].fkEmpresa
                        });
                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function cadastrar(req, res) {
    var nome = req.body.nomeServer;
    var email = req.body.emailServer;
    var cpf = req.body.cpfServer;
    var telefone = req.body.telefoneServer;
    var senha = req.body.senhaServer;
    var fkEmpresa = req.body.idEmpresaVincularServer;

    if (!nome) {
        res.status(400).send("Seu nome está undefined ou vazio!");
    } else if (!email) {
        res.status(400).send("Seu email está undefined ou vazio!");
    } else if (!cpf) {
        res.status(400).send("Seu CPF está undefined ou vazio!");
    } else if (!telefone) {
        res.status(400).send("Seu telefone está undefined ou vazio!");
    } else if (!senha) {
        res.status(400).send("Sua senha está undefined ou vazia!");
    } else if (!fkEmpresa) {
        res.status(400).send("Sua empresa a vincular está undefined!");
    } else {

        usuarioModel.cadastrar(nome, email, cpf, telefone, senha, fkEmpresa)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );

                    // Violação de UNIQUE (e-mail ou CPF repetido)
                    if (erro.code == "ER_DUP_ENTRY") {
                        res.status(409).send("E-mail ou CPF já cadastrado!");
                    } else {
                        res.status(500).json(erro.sqlMessage);
                    }
                }
            );
    }
}

module.exports = {
    autenticar,
    cadastrar
}