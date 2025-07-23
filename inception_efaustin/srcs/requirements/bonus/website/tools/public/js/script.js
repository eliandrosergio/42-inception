
// Secção Global var -------------------------------------------

// Global var img

const mira = document.querySelector('.mira')
const alvo = document.querySelector('.alvo')

// Global var buttons

const recarregarButton = document.querySelector('.recarregar')
const municaoButton = document.querySelector('.pegarMunicao')

// Global var audio

let somTiro = new Audio("./sounds/tiro.wav")
let somGameOver = new Audio("./sounds/gameover.mp3")
let somRecarregar1 = new Audio("./sounds/recarregar-arma-1.wav")
let somRecarregar2 = new Audio("./sounds/recarregar-arma-2.wav")
let somMunicao = new Audio("./sounds/recarregar-balas-extra.wav")

// Global var text

const tempoText = document.querySelector('.tempo')
const pontosTexto = document.querySelector('.pontos')
const municaoText = document.querySelector('.municao')
const notificacaoText = document.querySelector('.notificacao')

// Global var

let tempo = 30
let pontos = 0
let balas = 30
let municao = 90

let mouseNoAlvo = false
let mouseNosButton = false

// Secçao Function ------------------------------------------

// Function Mostrar

function mostrarMunicao() {
    municaoText.innerHTML = `${balas} | ${municao}`
}

function mostrarPontos() {
    pontosTexto.innerHTML = pontos
}

function mostrarTempo() {
    tempoText.innerHTML = tempo
}

// Function Tempo

function iniciarTempo() {
    setInterval(
        () => {
            tempoContando()
        }, 1000
    )
}

function tempoContando() {
    if (tempo > 0) {
        tempo -= 1
        mostrarTempo()
    }
    
    if (tempo == 10 || tempo == 5) {
        notificacaoText.innerHTML = 'Seu tempo está a terminar, jovem!'
    }
    
    if (tempo == 0) {
        somGameOver.volume = 1
        somGameOver.play()
        gameOver()
    }
}

// Function Game Over

function gameOver() {
	let alerta1 = confirm(`Game Over! \n Seus pontos = ${pontos} \n\nQuer jogar novamente?`)

    notificacaoText.innerHTML = 'Olá, novamente, jovem!'

    if (alerta1 == true) {
        tempo = 30 + 1
    }
    else if (alerta1 == false) {
        let alerta2 = confirm(`Deseja mesmo sair?`)

        if (alerta2 == true) {
            window.close()
        }
        else if (alerta2 == false) {
            tempo = 30 + 1
        }
    }
}

// Function Mira

function moverMira(e) {
    mira.style.left = `${e.clientX}px`
    mira.style.top = `${e.clientY}px`
}

// Function Mudar posição do alvo

function mudarPosicao() {
    const eixoX = Math.floor(Math.random() * 644)
    const eixoY = Math.floor(Math.random() * 444)

    alvo.style.top = `${eixoY}px`
    alvo.style.left = `${eixoX}px`
}

// Functions de verificação

function armaTemBalas() {
    let balaBool

    if (balas == 0) {
        balaBool = false
    }
    else if (balas != 0) {
        balaBool = true
    }

    return balaBool
}

function municaoTemBalas() {
    let municaoBool

    if (municao == 0) {
        municaoBool = false
    }
    else if (municao != 0) {
        municaoBool = true
    }

    return municaoBool
}

// Functions Ações da arma

function recarregarBalas() {
    if (municaoTemBalas() == true && armaTemBalas() == false) {
        somRecarregar1.volume = 0.06
        somRecarregar2.volume = 0.06
        somRecarregar1.play()
        somRecarregar2.play()

        balas = 30
        municao = municao - 30

        notificacaoText.innerHTML = 'Pronto pra acção, jovem?'
        mostrarMunicao()
    }
    else if (municaoTemBalas() == true && armaTemBalas() == true) {
        notificacaoText.innerHTML = 'Ainda tens bala, jovem!'
    }
    else {
        notificacaoText.innerHTML = 'Estás sem munição, jovem!'
    }
}

function pegarMaisMunicao() {
    if (balas == 30 && municao == 90) {
        notificacaoText.innerHTML = 'Já está cheio, jovem!'
    }
    else {
        somMunicao.volume = 0.06
        somMunicao.play()

        balas = 30
        municao = 90

        notificacaoText.innerHTML = 'Pronto pra acção, jovem?'
        mostrarMunicao()
    }
}

// Function Mouse

function mouseButtonEntrou() {
    mouseNosButton = true
}

function mouseButtonSaiu() {
    mouseNosButton = false
}

function mouseAlvoEntrou() {
    mouseNoAlvo = true
}

function mouseAlvoSaiu() {
    mouseNoAlvo = false
}

// Function Arma disparada

function armaDisparada() {
    if (mouseNosButton == false) {
        if (armaTemBalas() == false) {
            notificacaoText.innerHTML = 'Estás sem balas, jovem!'
        }
        
        if (armaTemBalas() == true) {
            if (mouseNoAlvo == false) {
                somTiro.volume = 0.04
                somTiro.currentTime = 0
                somTiro.play()

                balas--
                notificacaoText.innerHTML = 'Que tiro péssimo, jovem!'
                mostrarMunicao()
            }
            else if (mouseNoAlvo == true) {
                somTiro.volume = 0.04
                somTiro.currentTime = 0
                somTiro.play()

                balas--
                pontos += 1
                pontosTexto.innerHTML = pontos
                notificacaoText.innerHTML = 'Bom tiro, jovem!'
        
                mostrarMunicao()
                mudarPosicao()
            }
        }
    }
}

// Secção dos Event -----------------------------------------

// Event mouseenter e mouseout

recarregarButton.addEventListener('mouseenter', mouseButtonEntrou)
recarregarButton.addEventListener('mouseout', mouseButtonSaiu)

municaoButton.addEventListener('mouseenter', mouseButtonEntrou)
municaoButton.addEventListener('mouseout', mouseButtonSaiu)

alvo.addEventListener('mouseenter', mouseAlvoEntrou)
alvo.addEventListener('mouseout', mouseAlvoSaiu)

// Event Document

document.addEventListener('mousemove', e => moverMira(e))
document.addEventListener('click', armaDisparada)

// Event Button

recarregarButton.addEventListener('click', recarregarBalas)
municaoButton.addEventListener('click', pegarMaisMunicao)

// Secção Call Function -------------------------------------

mostrarMunicao()
mostrarPontos()

mostrarTempo()
iniciarTempo()
