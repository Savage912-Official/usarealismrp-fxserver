let inGameMoney;

window.addEventListener('message', function(event) {
    if (event.data.action == "open") {
      $('#main-container').css('display','block');
    } else if (event.data.action == "close") {
      $('#main-container').css('display','none');


    } else if (event.data.approveMoney == "open") {
        inGameMoney = event.data.luaCashMoney;
    }
});

$.post('https://oe-aviator/loadMoney', JSON.stringify({}));
setInterval(() => {
    $.post('https://oe-aviator/loadMoney', JSON.stringify({}));
    $('.money-container p').text(`${Number(inGameMoney).toFixed(2)}$`)
}, 50);


//interavls
let rotateInterval, animationInterval, coeffNumInterval, countdownInterval, betGainInterval1, betGainInterval2;

//numbers
let rotateNum, gifPositionNum, countDownFirst, countdownSecond;

let youCanCashout1 = false;
let youCanCashout2 = false;

let playBetRound1 = false;
let playBetRound2 = false;

let betGainMoney1, betGainMoney2;

let coefText;

//arrays
let historyItemDB = localStorage.setHistoryItemDB !== undefined ? JSON.parse(localStorage.setHistoryItemDB) : [];

let coeffArr = ['1.56', '1.42', '2.35', '1.87', '7.55', '3.63', '4.94', '1.80', '2.08', '1.33', '28.69', '2.42', '7.27'];
let historyCoeffDB = localStorage.setHistoryCoeffDB !== undefined ? JSON.parse(localStorage.setHistoryCoeffDB) : [];

if (historyCoeffDB.length == 0 ) {
    for (let i of coeffArr) {
        historyCoeffDB.push(i);
    }
}






function startGame() {
    rotateNum = 0;

    $('.aviator-game-container').removeClass('aviator-container-backgroundTransparent')
    $('.aviator-game-container').addClass('aviator-container-backgroundBlue')

    //rotate animation
    rotateInterval = setInterval(() => {
        rotateNum += 0.015;
    
        let stopLimit = 17;
       
        if (Number(rotateNum).toFixed(0) < stopLimit) {
            $('.aviator-game-container').css(`transform`, `rotate(-${rotateNum}deg)`)
        } 
    }, 10);
}

function runAnimation() {
    gifPositionNum = 0;
    
    $('.aviator-run-gif').attr('src', './img/run.gif')

    animationInterval = setInterval(() => {
        let containerWidth = $('.aviator-game-container').css('width').slice(0, -2);
        let animationLeftPosition = $('.aviator-run-gif').css('left').slice(0, -2);
        
        if (animationLeftPosition < containerWidth - 63) {
            gifPositionNum += 0.07;
            $('.aviator-run-gif').css('left', `${gifPositionNum}vh`)
        }

    }, 10);
}

function coeffIncrase() {
    let coeffNumFirst = 1;
    let coeffNumSecond = 0;
    

    let precision = 100;
    let stopNum; 

    //chance of the number that will come out
    let coeffChance = Math.floor(Math.random() * 101);

    if (coeffChance >= 3 && coeffChance < 85 ) {
        stopNum = Math.floor(Math.random() * (3 * precision - 1 * precision) + 1 * precision) / (1*precision);

    } else if (coeffChance >= 85 ) {
        stopNum = Math.floor(Math.random() * (8 * precision - 1 * precision) + 1 * precision) / (1*precision);

    } else if ( coeffChance < 3) {
        stopNum = Math.floor(Math.random() * (35 * precision - 1 * precision) + 1 * precision) / (1*precision);
    }

    coeffNumInterval = setInterval(() => {
        coefText = $('.aviator-coeff-duration').text();

        if ( $('.waiting-nextRound-container').css('display') == 'none' ) {
            coeffNumSecond += 1;
            if (coeffNumSecond == 100) {
                coeffNumFirst += 1;
                coeffNumSecond = 0;
            }
            
            if (coeffNumSecond < 10) {
                $('.aviator-coeff-duration').text(`${coeffNumFirst}.0${coeffNumSecond}x`)
            } else {
                $('.aviator-coeff-duration').text(`${coeffNumFirst}.${coeffNumSecond}x`)
            }       
        }

        if ( $('#bet1-autoCash-switch-input').is(':checked') ) {
            if (coefText.slice(0, -1) == $('#bet1-autoplay-input').val()) {
                if ( playBetRound1 == true ) {

                    historyitems(betInput1Val, coefText, Number(betGainMoney1).toFixed(2));

                    gainNotification(coefText.slice(0, -1), Number(betGainMoney1))

                    clearInterval(betGainInterval1)
                    youCanCashout1 = false;
            
    
                    if ($('.autoplay1').css('display') == 'flex' ) {
                        $('.betMoney1-bet-btn').css({
                            'height': '8.5vh',
                            'top': '4vh',
                            'background-color': '#28a909',
                            'box-shadow': '0 0 8px #29a909af',
                        })
                    } else {
                        $('.betMoney1-bet-btn').css({
                            'height': '8.5vh',
                            'top': '6vh',
                            'background-color': '#28a909',
                            'box-shadow': '0 0 8px #29a909af',
                        })
                    }
    
                    $('.betMoney1-bet-btn .betWord').text('BET')
                    $('.betMoney1-bet-btn .coeffWord').text('')
                    $('.betMoney1-bet-btn .betWord').css('top', '1.1vh')
            
                    $('.betMoney1-bet-btn').removeClass('bet-roundStarted')
                    $('.betMoney1-bet-btn').removeClass('bet-roundNotStarted')
            
                    readonlyOpacity1('openInput')

                    $.post('https://oe-aviator/addMoneyCallBack', JSON.stringify(Math.ceil(betGainMoney1)));
    
                    youCanCashout1 = false;  
                    
                }
            }
        }

        if ( $('#bet2-autoCash-switch-input').is(':checked') ) {
            if (coefText.slice(0, -1) == $('#bet2-autoplay-input').val()) {
                if ( playBetRound2 == true ) {

                    historyitems(betInput2Val, coefText, Number(betGainMoney2).toFixed(2));

                    gainNotification(coefText.slice(0, -1), Number(betGainMoney2))

                    clearInterval(betGainInterval2)
                    youCanCashout2 = false;
            
                    if ($('.autoplay2').css('display') == 'flex' ) {
                        $('.betMoney2-bet-btn').css({
                            'height': '8.5vh',
                            'top': '4vh',
                            'background-color': '#28a909',
                            'box-shadow': '0 0 8px #29a909af',
                        })
                    } else {
                        $('.betMoney2-bet-btn').css({
                            'height': '8.5vh',
                            'top': '6vh',
                            'background-color': '#28a909',
                            'box-shadow': '0 0 8px #29a909af',
                        })
                    }
    
                    $('.betMoney2-bet-btn .betWord').text('BET')
                    $('.betMoney2-bet-btn .coeffWord').text('')
                    $('.betMoney2-bet-btn .betWord').css('top', '1.1vh')
            
                    $('.betMoney2-bet-btn').removeClass('bet-roundStarted')
                    $('.betMoney2-bet-btn').removeClass('bet-roundNotStarted')
            
                    readonlyOpacity2('openInput')

                    $.post('https://oe-aviator/addMoneyCallBack', JSON.stringify(Math.ceil(betGainMoney2)));
    
                    youCanCashout2 = false;  
                    
                }
            }
        }
        
        if ( coefText.slice(0, -1) == stopNum.toFixed(2)) {
            
            if (youCanCashout1 == true) {                        
                clearInterval(betGainInterval1)
                youCanCashout1 = false;
        

                if ($('.autoplay1').css('display') == 'flex' ) {
                    $('.betMoney1-bet-btn').css({
                        'height': '8.5vh',
                        'top': '4vh',
                        'background-color': '#28a909',
                        'box-shadow': '0 0 8px #29a909af',
                    })
                } else {
                    $('.betMoney1-bet-btn').css({
                        'height': '8.5vh',
                        'top': '6vh',
                        'background-color': '#28a909',
                        'box-shadow': '0 0 8px #29a909af',
                    })
                }

                $('.betMoney1-bet-btn .betWord').text('BET')
                $('.betMoney1-bet-btn .coeffWord').text('')
                $('.betMoney1-bet-btn .betWord').css('top', '1.1vh')
        
                $('.betMoney1-bet-btn').removeClass('bet-roundStarted')
                $('.betMoney1-bet-btn').removeClass('bet-roundNotStarted')
        
                readonlyOpacity1('openInput')

                youCanCashout1 = false;         
            }

            if (youCanCashout2 == true) {                        
                clearInterval(betGainInterval2)
                youCanCashout2 = false;
        

                if ($('.autoplay2').css('display') == 'flex' ) {
                    $('.betMoney2-bet-btn').css({
                        'height': '8.5vh',
                        'top': '4vh',
                        'background-color': '#28a909',
                        'box-shadow': '0 0 8px #29a909af',
                    })
                } else {
                    $('.betMoney2-bet-btn').css({
                        'height': '8.5vh',
                        'top': '6vh',
                        'background-color': '#28a909',
                        'box-shadow': '0 0 8px #29a909af',
                    })
                }

                $('.betMoney2-bet-btn .betWord').text('BET')
                $('.betMoney2-bet-btn .coeffWord').text('')
                $('.betMoney2-bet-btn .betWord').css('top', '1.1vh')
        
                $('.betMoney2-bet-btn').removeClass('bet-roundStarted')
                $('.betMoney2-bet-btn').removeClass('bet-roundNotStarted')
        
                readonlyOpacity2('openInput')

                youCanCashout2 = false;         
            }


            stopAnimation();

            let editTextForPrepend = Number(coefText.slice(0, -1 )) + 0.01;
            let prependItem = `<div class="history-round-item">${editTextForPrepend.toFixed(2)}x</div>`;
            historyCoeffDB.unshift(editTextForPrepend.toFixed(2))
            historyCoeffDB.splice(48, historyCoeffDB.length);
            localStorage.setHistoryCoeffDB = JSON.stringify(historyCoeffDB)

            let itemLength = $('.enlarge-container-round-item .history-round-item').length;

            if (itemLength > 49) {
                $('.enlarge-container-round-item .history-round-item:last-child').remove();
                $('.history-rounds-main .history-round-item:last-child').remove();
                $('.enlarge-container-round-item, .history-rounds-main').prepend(prependItem)
            } else {
                $('.enlarge-container-round-item, .history-rounds-main').prepend(prependItem)                
            }

            changeColorFromCoeff('miniItem');


            $('.aviator-square1').css('background', 'rgb(189, 8, 50)')
            $('.aviator-container').css('background', 'linear-gradient(rgb(23,24,25) 45%, rgba(255, 0, 0, 0.15))')
            $('.aviator-game-container').css('border-color', 'rgb(189, 8, 50)')

            $('.aviator-game-container').removeClass('aviator-container-backgroundBlue')
            $('.aviator-game-container').removeClass('aviator-container-backgroundTransparent')
            $('.aviator-game-container').addClass('aviator-container-backgroundRed')

            $('.aviator-game-container img').attr('src', './img/fall.gif')
            $('.aviator-game-container img').css('top', '-5.4vh')

            $('.fellDown-text').css('display', 'block')
            $('.aviator-coeff-duration').css('color', 'rgb(186, 8, 49)')

            setTimeout(() => {
                geriSayimBasla();             
            }, 3000);
        }
    }, 70);
}

function geriSayimBasla() {
    clearInterval(betGainInterval1)
    clearInterval(betGainInterval2)
    $('.betMoney1-bet-btn').removeClass('bet-roundNotStarted')
    $('.betMoney2-bet-btn').removeClass('bet-roundNotStarted')


    if ( $('.betWaitTitle1').css('display') == 'none' ) {
        playBetRound1 = false;

        if ($('.autoplay1').css('display') == 'flex' ) {
            $('.betMoney1-bet-btn').css({
                'height': '8.5vh',
                'top': '4vh',
                'background-color': '#28a909',
                'box-shadow': '0 0 8px #29a909af',
            })
        } else {
            $('.betMoney1-bet-btn').css({
                'height': '8.5vh',
                'top': '6vh',
                'background-color': '#28a909',
                'box-shadow': '0 0 8px #29a909af',
            })
        }

        $('.betMoney1-bet-btn .betWord').text('BET')

        $('.betMoney1-bet-btn .coeffWord').text('')
        $('.betMoney1-bet-btn .betWord').css('top', '1.1vh')
    }

    if ( $('.betWaitTitle2').css('display') == 'none' ) {
        playBetRound2 = false;

        if ($('.autoplay2').css('display') == 'flex' ) {
            $('.betMoney2-bet-btn').css({
                'height': '8.5vh',
                'top': '4vh',
                'background-color': '#28a909',
                'box-shadow': '0 0 8px #29a909af',
            })
        } else {
            $('.betMoney2-bet-btn').css({
                'height': '8.5vh',
                'top': '6vh',
                'background-color': '#28a909',
                'box-shadow': '0 0 8px #29a909af',
            })
        }

        $('.betMoney2-bet-btn .betWord').text('BET')
        $('.betMoney2-bet-btn .coeffWord').text('')
        $('.betMoney2-bet-btn .betWord').css('top', '1.1vh')
    }



    $('.aviator-coeff-duration').css('display', 'none')
    $('.waiting-nextRound-container').css('display', 'block')

    $('.aviator-square1').css('background', 'rgb(106,200,242)')
    $('.aviator-container').css('background', 'rgb(23,24,25)')
    $('.aviator-game-container').css({
        'border-color': 'rgb(106,200,242)',
        'transform': 'rotate(0deg)'
    })
    $('.aviator-run-gif').attr('src', './img/runImage.png')
    $('.aviator-game-container img').css({
        'top': '-6.4vh',
        'left': '0',
    })
    $('.aviator-game-container').removeClass('aviator-container-backgroundRed')
    $('.aviator-game-container').addClass('aviator-container-backgroundTransparent')

    $('.betWaitTitle1, .betWaitTitle2').css('display', 'none')

    if ($('.autoplay1').css('display') == 'flex' ) {
        $('.betMoney1-bet-btn').css({
            'height': '8.5vh',
            'top': '4vh',
        })
    } else {
        $('.betMoney1-bet-btn').css({
            'height': '8.5vh',
            'top': '6vh',
        })
    }

    if ($('.autoplay2').css('display') == 'flex' ) {
        $('.betMoney2-bet-btn').css({
            'height': '8.5vh',
            'top': '4vh',
        })
    } else {
        $('.betMoney2-bet-btn').css({
            'height': '8.5vh',
            'top': '6vh',
        })
    }

    $('.betMoney1-bet-btn .betWord').css('top', '1.1vh')
    $('.betMoney2-bet-btn .betWord').css('top', '1.1vh')

    $('.fellDown-text').css('display', 'none')
    $('.aviator-coeff-duration').css('color', 'white')

    countDownFirst = 4;
    countdownSecond = 99;

    countdownInterval = setInterval(() => {
        let textVal = $('.waiting-nextRound-container span p').text();
        
        if (textVal != '0.01s') {
            countdownSecond = countdownSecond - 1;

            if (countdownSecond == 0 ) {
                countDownFirst = countDownFirst - 1;
                countdownSecond = 99;
            }      
        }   

        if (countdownSecond > 9) {
            $('.waiting-nextRound-container span p').text(`${countDownFirst}.${countdownSecond}s`)
        } else {
            $('.waiting-nextRound-container span p').text(`${countDownFirst}.0${countdownSecond}s`)
        }     
        

        if (countdownSecond == 1 && countDownFirst == 0) {
            if ( $('.waiting-nextRound-container').css('display') == 'block' ) {
                sifirlaHerseyi();

                $('.aviator-run-gif').attr('src', './img/run.gif')
                $('.waiting-nextRound-container').css('display', 'none')
                $('.aviator-coeff-duration').css('display', 'block')

                $('.aviator-game-container').removeClass('aviator-container-backgroundTransparent')
                $('.aviator-game-container').addClass('aviator-container-backgroundBlue')



                if ( $('.betMoney1-bet-btn .betWord').text() == 'CANCEL' ) {
                    betGainWrite1();
                }

                if ( $('.betMoney2-bet-btn .betWord').text() == 'CANCEL' ) {
                    betGainWrite2();
                }
            }
        }
        
    }, 10);

}


startGame();
runAnimation();
coeffIncrase();



function sifirlaHerseyi() {
    clearInterval(rotateInterval)
    clearInterval(animationInterval)
    clearInterval(coeffNumInterval)
    clearInterval(countdownInterval)

    startGame();
    runAnimation();
    coeffIncrase();
}

function stopAnimation() {
    clearInterval(rotateInterval)
    clearInterval(animationInterval)
    clearInterval(coeffNumInterval)
    clearInterval(countdownInterval)
}


historyCoeffDB.forEach(function(x, i) {
    let foreachItem = `<div class="history-round-item">${x}x</div>`;

    $('.enlarge-container-round-item, .history-rounds-main').append(foreachItem)
});




let betInput1Val, betInput2Val;

$('.betMoney1-bet-btn').click(function(){
    betInput1Val = $('#betMoney1').val();

    if (youCanCashout1 == true) {

        historyitems(betInput1Val, coefText, Number(betGainMoney1).toFixed(2));

        gainNotification(coefText.slice(0, -1), Number(betGainMoney1).toFixed(2))


        clearInterval(betGainInterval1)
        youCanCashout1 = false;

        if ($('.autoplay1').css('display') == 'flex' ) {
            $('.betMoney1-bet-btn').css({
                'height': '8.5vh',
                'top': '4vh',
                'background-color': '#28a909',
                'box-shadow': '0 0 8px #29a909af',
            })
        } else { 
            $('.betMoney1-bet-btn').css({
                'height': '8.5vh',
                'top': '6vh',
                'background-color': '#28a909',
                'box-shadow': '0 0 8px #29a909af',
            })
        }

        $('.betMoney1-bet-btn .betWord').text('BET')
        $('.betMoney1-bet-btn .coeffWord').text('')
        $('.betMoney1-bet-btn .betWord').css('top', '1.1vh')

        $('.betMoney1-bet-btn').removeClass('bet-roundStarted')
        $('.betMoney1-bet-btn').removeClass('bet-roundNotStarted')

        readonlyOpacity1('openInput')

        $.post('https://oe-aviator/addMoneyCallBack', JSON.stringify(Math.ceil(betGainMoney1)));
 
        return
    }


    if (youCanCashout1 == false ) {
        
        if ($('.betMoney1-bet-btn').css('background-color') != 'rgb(199, 107, 1)') {

            if ( $('.betMoney1-bet-btn').hasClass('bet-roundStarted') || $('.betMoney1-bet-btn').hasClass('bet-roundNotStarted') ) {
                playBetRound1 = false;

                $('.betMoney1-bet-btn .betWord').css('top', '1.1vh')

                if ($('.autoplay1').css('display') == 'flex' ) {
                    $('.betMoney1-bet-btn').css({
                        'height': '8.5vh',
                        'top': '4vh',
                        'background-color': '#28a909',
                        'box-shadow': '0 0 8px #29a909af',
                    })
                } else {
                    $('.betMoney1-bet-btn').css({
                        'height': '8.5vh',
                        'top': '6vh',
                        'background-color': '#28a909',
                        'box-shadow': '0 0 8px #29a909af',
                    })
                }

                $('.betMoney1-bet-btn .betWord').text('BET')
                $('.betWaitTitle1').css('display', 'none')
                $('.betMoney1-bet-btn').removeClass('bet-roundStarted')
                $('.betMoney1-bet-btn').removeClass('bet-roundNotStarted')

                readonlyOpacity1('openInput')

                $.post('https://oe-aviator/addMoneyCallBack', JSON.stringify(Number(betInput1Val).toFixed(0)));

                return
            }


            if ( Number($('.money-container p').text().slice(0, -1)) >= Number(betInput1Val)) {

                if ( $('.waiting-nextRound-container').css('display') == 'block' ) {

                    playBetRound1 = true;

                    $('.betMoney1-bet-btn').css({
                        'background-color': 'rgba(203,1,26,255)',
                        'box-shadow': '0 0 8px rgba(203, 1, 25, 0.733)',
                    })
                    $('.betMoney1-bet-btn .betWord').text('CANCEL')

                    $('.betMoney1-bet-btn').removeClass('bet-roundStarted')
                    $('.betMoney1-bet-btn').addClass('bet-roundNotStarted')

                    readonlyOpacity1('closeInput')

                    $.post('https://oe-aviator/removeMoneyCallBack', JSON.stringify(Number(betInput1Val).toFixed(0)));

                } else {
                    $('.betMoney1-bet-btn .betWord').css('top', '0')

                    playBetRound1 = true;

                    $('.betMoney1-bet-btn').addClass('bet-roundStarted')

                    if ($('.autoplay1').css('display') == 'flex' ) {
                        $('.betMoney1-bet-btn').css({
                            'height': '6.5vh',
                            'top': '6vh',
                            'background-color': 'rgba(203,1,26,255)',
                            'box-shadow': '0 0 8px rgba(203, 1, 25, 0.733)',
                        })
                    } else {
                        $('.betMoney1-bet-btn').css({
                            'height': '6.5vh',
                            'top': '8vh',
                            'background-color': 'rgba(203,1,26,255)',
                            'box-shadow': '0 0 8px rgba(203, 1, 25, 0.733)',
                        })
                    }

                    $('.betMoney1-bet-btn .betWord').text('CANCEL')

                    if ( $('.betMoney1-bet-btn').hasClass('bet-roundStarted') ) {
                        $('.betWaitTitle1').css('display', 'block')

                        if ($('.autoplay1').css('display') == 'flex' ) {
                            $('.bet-wait-round-title.betWaitTitle1').css('top', '3.8vh')
                        } else {
                            $('.bet-wait-round-title.betWaitTitle1').css('top', '5.8vh')
                        }
                    }

                    readonlyOpacity1('closeInput')

                    $.post('https://oe-aviator/removeMoneyCallBack', JSON.stringify(Number(betInput1Val).toFixed(0)));

                }

            }
        }
        
    }

});




$('.betMoney2-bet-btn').click(function(){
    betInput2Val = $('#betMoney2').val();

    if (youCanCashout2 == true) {
        
        historyitems(betInput2Val, coefText, Number(betGainMoney2).toFixed(2));


        gainNotification(coefText.slice(0, -1), Number(betGainMoney2))

        clearInterval(betGainInterval2)
        youCanCashout2 = false;

        if ($('.autoplay2').css('display') == 'flex' ) {
            $('.betMoney2-bet-btn').css({
                'height': '8.5vh',
                'top': '4vh',
                'background-color': '#28a909',
                'box-shadow': '0 0 8px #29a909af',
            })
        } else { 
            $('.betMoney2-bet-btn').css({
                'height': '8.5vh',
                'top': '6vh',
                'background-color': '#28a909',
                'box-shadow': '0 0 8px #29a909af',
            })
        }

        $('.betMoney2-bet-btn .betWord').text('BET')
        $('.betMoney2-bet-btn .coeffWord').text('')
        $('.betMoney2-bet-btn .betWord').css('top', '1.1vh')

        $('.betMoney2-bet-btn').removeClass('bet-roundStarted')
        $('.betMoney2-bet-btn').removeClass('bet-roundNotStarted')

        readonlyOpacity2('openInput')

        $.post('https://oe-aviator/addMoneyCallBack', JSON.stringify(Math.ceil(betGainMoney2)));
 
        return
    }



    //eger cash out bolumunde değilse 
    if (youCanCashout2 == false ) {
        
        if ($('.betMoney2-bet-btn').css('background-color') != 'rgb(199, 107, 1)') {

            if ( $('.betMoney2-bet-btn').hasClass('bet-roundStarted') || $('.betMoney2-bet-btn').hasClass('bet-roundNotStarted') ) {
                playBetRound2 = false;

                $('.betMoney2-bet-btn .betWord').css('top', '1.1vh')

                if ($('.autoplay2').css('display') == 'flex' ) {
                    $('.betMoney2-bet-btn').css({
                        'height': '8.5vh',
                        'top': '4vh',
                        'background-color': '#28a909',
                        'box-shadow': '0 0 8px #29a909af',
                    })
                } else {
                    $('.betMoney2-bet-btn').css({
                        'height': '8.5vh',
                        'top': '6vh',
                        'background-color': '#28a909',
                        'box-shadow': '0 0 8px #29a909af',
                    })
                }

                $('.betMoney2-bet-btn .betWord').text('BET')
                $('.betWaitTitle2').css('display', 'none')
                $('.betMoney2-bet-btn').removeClass('bet-roundStarted')
                $('.betMoney2-bet-btn').removeClass('bet-roundNotStarted')

                readonlyOpacity2('openInput')

                $.post('https://oe-aviator/addMoneyCallBack', JSON.stringify(Number(betInput2Val).toFixed(0)));

                return
            }

            if ( Number($('.money-container p').text().slice(0, -1)) >= Number(betInput2Val)) {

                if ( $('.waiting-nextRound-container').css('display') == 'block' ) {

                    playBetRound2 = true;
    
                    $('.betMoney2-bet-btn').css({
                        'background-color': 'rgba(203,1,26,255)',
                        'box-shadow': '0 0 8px rgba(203, 1, 25, 0.733)',
                    })
                    $('.betMoney2-bet-btn .betWord').text('CANCEL')
    
                    $('.betMoney2-bet-btn').removeClass('bet-roundStarted')
                    $('.betMoney2-bet-btn').addClass('bet-roundNotStarted')
    
                    readonlyOpacity2('closeInput')
    
                    $.post('https://oe-aviator/removeMoneyCallBack', JSON.stringify(Number(betInput2Val).toFixed(0)));
    
                } else {
    
                    $('.betMoney2-bet-btn .betWord').css('top', '0')
    
                    playBetRound2 = true;
    
                    $('.betMoney2-bet-btn').addClass('bet-roundStarted')
    
                    if ($('.autoplay2').css('display') == 'flex' ) {
                        $('.betMoney2-bet-btn').css({
                            'height': '6.5vh',
                            'top': '6vh',
                            'background-color': 'rgba(203,1,26,255)',
                            'box-shadow': '0 0 8px rgba(203, 1, 25, 0.733)',
                        })
                    } else {
                        $('.betMoney2-bet-btn').css({
                            'height': '6.5vh',
                            'top': '8vh',
                            'background-color': 'rgba(203,1,26,255)',
                            'box-shadow': '0 0 8px rgba(203, 1, 25, 0.733)',
                        })
                    }
    
                    $('.betMoney2-bet-btn .betWord').text('CANCEL')
    
                    if ( $('.betMoney2-bet-btn').hasClass('bet-roundStarted') ) {
                        $('.betWaitTitle2').css('display', 'block')
    
                        if ($('.autoplay2').css('display') == 'flex' ) {
                            $('.bet-wait-round-title.betWaitTitle2').css('top', '3.8vh')
                        } else {
                            $('.bet-wait-round-title.betWaitTitle2').css('top', '5.8vh')
                        }
                    }
    
                    readonlyOpacity2('closeInput')
    
                    $.post('https://oe-aviator/removeMoneyCallBack', JSON.stringify(Number(betInput2Val).toFixed(0)));
                }
                
            }

        }
        
    }

});



function betGainWrite1() {
    youCanCashout1 = true;
    $('.betMoney1-bet-btn').css({'background-color': 'rgb(199, 107, 1)', 'box-shadow': '0 0 8px rgba(199, 107, 1, 0.7)'})
    
    $('.betMoney1-bet-btn .betWord').text('CASH OUT')
    $('.betMoney1-bet-btn .betWord').css('top', '-0.2vh')
    $('.betMoney1-bet-btn .coeffWord').css('top', '2.3vh')

    betGainInterval1 = setInterval(() => {
        if (playBetRound1 == true) {
            let coefTextForWrite = Number($('.aviator-coeff-duration').text().slice(0, -1));
            betGainMoney1 = Number(betInput1Val * coefTextForWrite).toFixed(2);
            $('.betMoney1-bet-btn .coeffWord').text(betGainMoney1 + '$')
        }
    }, 10);    
}

function betGainWrite2() {
    youCanCashout2 = true;
    $('.betMoney2-bet-btn').css({'background-color': 'rgb(199, 107, 1)', 'box-shadow': '0 0 8px rgba(199, 107, 1, 0.7)'})
    
    $('.betMoney2-bet-btn .betWord').text('CASH OUT')
    $('.betMoney2-bet-btn .betWord').css('top', '-0.2vh')
    $('.betMoney2-bet-btn .coeffWord').css('top', '2.3vh')

    betGainInterval2 = setInterval(() => {
        if (playBetRound2 == true) {
            let coefTextForWrite = Number($('.aviator-coeff-duration').text().slice(0, -1));
            betGainMoney2 = Number(betInput2Val * coefTextForWrite).toFixed(2);
            $('.betMoney2-bet-btn .coeffWord').text(betGainMoney2 + '$')
        }
    }, 10);    
}




function readonlyOpacity1(name) {
    switch (name) {
        case 'closeInput':
            $('#betMoney1').attr('readonly', 'readonly')
            $('.bet-buttons-main-container:first-child .bet-money-buttons-container').css('opacity', '0.6')
            break;

        case 'openInput':
            $('#betMoney1').removeAttr('readonly')
            $('.bet-buttons-main-container:first-child .bet-money-buttons-container').css('opacity', '1')
            break;

        default:
            break;
    }
}

function readonlyOpacity2(name) {
    switch (name) {
        case 'closeInput':
            $('#betMoney2').attr('readonly', 'readonly')
            $('.bet-buttons-main-container:last-child .bet-money-buttons-container').css('opacity', '0.6')
            break;

        case 'openInput':
            $('#betMoney2').removeAttr('readonly')
            $('.bet-buttons-main-container:last-child .bet-money-buttons-container').css('opacity', '1')
            break;

        default:
            break;
    }
}

let notif;
function gainNotification(notifCoeff, notifGain) {

    notif = document.createElement('div');
    notif.classList.add('notification-contanier');

    notif.innerHTML += `
        <div class="notification-leftSide">
            <p class="notification-cashedOut">You have cashed out!</p>
            <p class="notification-coeff">${notifCoeff}x</p>
        </div>

        <div class="notification-gain-container">
            <p>You got:</p>
            <p>${notifGain}$</p>
            <i class="fa-solid fa-star leftStar"></i>
            <i class="fa-solid fa-star rightStar"></i>
        </div>
    `;

    $('.notification-main-container').append(notif)
    $(notif).css('display', 'block')
    $(notif).animate({
        opacity: '1',
        top: '+=1vh'
    }, 300, function(){
        //notif remove
        setTimeout(() => {
            $(this).animate({
                opacity: '0',
                top: '-=1vh'
            }, 300, function(){
                $(this).remove();
            })
        }, 3500)
    })

}



let historyItem;
function historyitems(historyBet, historyCoeff, historyGain) {
    historyItem = document.createElement('div');
    historyItem.classList.add('history-item');

    let historyItemObject = {
        bet: historyBet, 
        coeff: historyCoeff, 
        gain: historyGain,
    };

    historyItemDB.unshift(historyItemObject)
    localStorage.setHistoryItemDB = JSON.stringify(historyItemDB)

    historyItem.innerHTML += `
        <p class="your-history-money">${historyBet}$</p>
        <div class="history-coeff-container">
            <div class="history-coeff">${historyCoeff}</div>
        </div>
        <p class="your-history-win">${historyGain}$</p>
    `;

    $('.history-item-main-container').prepend(historyItem)

    calculateHistoryLength();
    changeColorFromCoeff('bigItem');
}


let itemHistory;
historyItemDB.forEach(function(x, i){
    itemHistory = document.createElement('div');
    itemHistory.classList.add('history-item');

    itemHistory.innerHTML += `
        <p class="your-history-money">${x.bet}$</p>
        <div class="history-coeff-container">
            <div class="history-coeff">${x.coeff}</div>
        </div>
        <p class="your-history-win">${x.gain}$</p>
    `;
    $('.history-item-main-container').append(itemHistory)
});


const coeffItem = document.getElementsByClassName('history-round-item')
const coeffItemBig = document.getElementsByClassName('history-coeff')
function changeColorFromCoeff(name) {

    switch (name) {
        case 'miniItem':
            for (let i = 0; i < coeffItem.length; i++) {

                let coeffText =  Number(coeffItem[i].innerHTML.slice(0, -1))
        
                if (coeffText < 2.00) {
                    coeffItem[i].style.backgroundColor = '#005d91';
                } else if (coeffText >= 2.00 && coeffText < 10.00) {
                    coeffItem[i].style.backgroundColor = '#6b07d2';
                } else if (coeffText >= 10.00) {
                    coeffItem[i].style.backgroundColor = '#900087';
                }
            }
            break;

        case 'bigItem':
            for (let i = 0; i < coeffItemBig.length; i++) {

                let coeffText =  Number(coeffItemBig[i].innerHTML.slice(0, -1))
        
                if (coeffText < 2.00) {
                    coeffItemBig[i].style.backgroundColor = '#005d91';
                } else if (coeffText >= 2.00 && coeffText < 10.00) {
                    coeffItemBig[i].style.backgroundColor = '#6b07d2';
                } else if (coeffText >= 10.00) {
                    coeffItemBig[i].style.backgroundColor = '#900087';
                }
            }
            break;
        default:
            break;
    }

}
changeColorFromCoeff('miniItem');
changeColorFromCoeff('bigItem');



$('.history-enlarge-btn').mouseenter(function(){
    $('.history-enlarge-btn i').css('color', 'red')
});

$('.history-enlarge-btn').mouseleave(function(){
    $('.history-enlarge-btn i:first-child').css('color', 'white')
    $('.history-enlarge-btn i:last-child').css('color', 'rgb(99, 99, 99)')
});


const englargeBtn = document.getElementsByClassName('history-enlarge-btn')

$('.history-enlarge-btn').click(function(){
    const englargeMenu = document.getElementsByClassName('history-enlarge-container')[0];
    let displaySetting = englargeMenu.style.display;


    if (displaySetting == 'block') {
        englargeMenu.style.display = 'none';

        $('.history-rounds').append(englargeBtn)
        $('.history-enlarge-btn').css({
            'position': 'relative',
            'right': '0',
            'top': '0',
        });

        $('.history-enlarge-btn .btnIcon2').css({
            'transform': 'rotate(90deg)',
            'top': '0.2vh',
        })

    } else {
        englargeMenu.style.display = 'block';

        $('.history-rounds').append(englargeBtn)
        $('.history-enlarge-btn').css({
            'position': 'relative',
            'right': '1vh',
            'top': '0.4vh',
        });

        $('.history-enlarge-btn .btnIcon2').css({
            'transform': 'rotate(270deg)',
            'top': '0.5vh',
        })
    }
});


$('.selectAuto1-btn').click(function(){
    $(this).addClass('selected')
    $('.selectBet1-btn').removeClass('selected')
    $('.bet-buttons-main-container:first-child .betAuto-selected').css('left', '8.5vh')

    $('.bet-buttons-main-container:first-child .bet-money-buttons-container, .betMoney1-bet-btn').css('top', '4vh')
    $('.bet-buttons-main-container:first-child .autoplay-container').css('display', 'flex')

    if ( $('.betWaitTitle1').css('display') == 'block' ) {
        $('.betMoney1-bet-btn').css('top', '6vh')
        $('.betWaitTitle1').css('top', '3.8vh')
    }
});

$('.selectBet1-btn').click(function(){
    $(this).addClass('selected')
    $('.selectAuto1-btn').removeClass('selected')
    $('.bet-buttons-main-container:first-child .betAuto-selected').css('left', '0')

    $('.bet-buttons-main-container:first-child .bet-money-buttons-container, .betMoney1-bet-btn').css('top', '6vh')
    $('.bet-buttons-main-container:first-child .autoplay-container').css('display', 'none')

    if ( $('.betWaitTitle1').css('display') == 'block' ) {
        $('.betMoney1-bet-btn').css('top', '8vh')
        $('.betWaitTitle1').css('top', '5.8vh')
    }
});

$('.selectAuto2-btn').click(function(){
    $(this).addClass('selected')
    $('.selectBet2-btn').removeClass('selected')
    $('.bet-buttons-main-container:last-child .betAuto-selected').css('left', '8.5vh')

    $('.bet-buttons-main-container:last-child .bet-money-buttons-container, .betMoney2-bet-btn').css('top', '4vh')
    $('.bet-buttons-main-container:last-child .autoplay-container').css('display', 'flex')

    if ( $('.betWaitTitle2').css('display') == 'block' ) {
        $('.betMoney2-bet-btn').css('top', '6vh')
        $('.betWaitTitle2').css('top', '3.8vh')
    }
});

$('.selectBet2-btn').click(function(){
    $(this).addClass('selected')
    $('.selectAuto2-btn').removeClass('selected')
    $('.bet-buttons-main-container:last-child .betAuto-selected').css('left', '0')

    $('.bet-buttons-main-container:last-child .bet-money-buttons-container, .betMoney2-bet-btn').css('top', '6vh')
    $('.bet-buttons-main-container:last-child .autoplay-container').css('display', 'none')

    if ( $('.betWaitTitle2').css('display') == 'block' ) {
        $('.betMoney2-bet-btn').css('top', '8vh')
        $('.betWaitTitle2').css('top', '5.8vh')
    }
});



$('#betMoney1-incrase').click(function(){
    let inputVal = $('#betMoney1').val();

    if ( !$('#betMoney1').is('[readonly]') ) {
        $('#betMoney1').val(Number(inputVal) + Number(1) + '.00')
        if ( inputVal > '9999.00' ) {
            $('#betMoney1').val('10000.00')
        }
    }
});

$('#betMoney1-decrase').click(function(){
    let inputVal = $('#betMoney1').val();

    if ( !$('#betMoney1').is('[readonly]') ) {
        $('#betMoney1').val(Number(inputVal) - Number(1) + '.00')
        if ( inputVal <= '1.00' ) {
            $('#betMoney1').val('1.00')
        }
    }
});

$('#betMoney2-incrase').click(function(){
    let inputVal = $('#betMoney2').val();

    if ( !$('#betMoney2').is('[readonly]') ) {
        $('#betMoney2').val(Number(inputVal) + Number(1) + '.00')
        if ( inputVal > '9999.00' ) {
            $('#betMoney2').val('10000.00')
        }
    }
});

$('#betMoney2-decrase').click(function(){
    let inputVal = $('#betMoney2').val();

    if ( !$('#betMoney2').is('[readonly]') ) {
        $('#betMoney2').val(Number(inputVal) - Number(1) + '.00')
        if ( inputVal <= '1.00' ) {
            $('#betMoney2').val('1.00')
        }
    }
});

$('.bet-money-input').keyup(function(){
    let inputVal = $('#betMoney1').val();
    

    if ( inputVal > 9999.00) {
        $('#betMoney1').val('10000.00')
    } else if ( inputVal <= 1.00) {
        $('#betMoney1').val('1.00')
    }

    if ( inputVal[0] == 0 && inputVal.length > 1 ) {
        $('#betMoney1').val(inputVal.slice(1, inputVal.length))
    }
});

const readyButtons1 = document.getElementsByClassName('bet-money-ready-buttons1')
for (let i = 0; i < readyButtons1.length; i++) {
    readyButtons1[i].addEventListener('click', function(){
        if ( !$('#betMoney1').is('[readonly]') ) {
            let numbers = readyButtons1[i].innerHTML.slice(0, readyButtons1[i].innerHTML.length - 1) + '.00';

            $('#betMoney1').val(numbers)
        }
    });    
}

const readyButtons2 = document.getElementsByClassName('bet-money-ready-buttons2')
for (let i = 0; i < readyButtons2.length; i++) {
    readyButtons2[i].addEventListener('click', function(){
        if ( !$('#betMoney2').is('[readonly]') ) {
            let numbers = readyButtons2[i].innerHTML.slice(0, readyButtons2[i].innerHTML.length - 1) + '.00';

            $('#betMoney2').val(numbers)
        }
    });    
}

$('#bet1-autoCash-switch-input').change(function(){
    if ($(this).is(':checked')) {
        $('#bet1-autoplay-input').removeAttr('readonly')
        $('#bet1-autoplay-input').css('color', 'white')
    } else {
        $('#bet1-autoplay-input').attr('readonly', 'readonly')
        $('#bet1-autoplay-input').css('color', 'rgb(122, 122, 123)')
    }
});

$('#bet2-autoCash-switch-input').change(function(){
    if ($(this).is(':checked')) {
        $('#bet2-autoplay-input').removeAttr('readonly')
        $('#bet2-autoplay-input').css('color', 'white')
    } else {
        $('#bet2-autoplay-input').attr('readonly', 'readonly')
        $('#bet2-autoplay-input').css('color', 'rgb(122, 122, 123)')
    }
});


$('.how-to-play').click(function(){
    $('.how-to-play-dark').fadeIn(200)
});

$('.how-to-play-topBar i').click(function(){
    $('.how-to-play-dark').fadeOut(200)
}); 

$('.how-to-play-dark').click(function(e){
    if ( !$(e.target).is('.how-to-play-container') && !$(e.target).is('.how-to-play-container *') ) {
        $(this).fadeOut(200)
    }
});

let historyItemLength;
function calculateHistoryLength() {
    historyItemLength = $('.history-item').length
    $('.history-container-number').text(historyItemLength)

    if (historyItemLength == 0 ) {
        $('.never-played').css('display', 'block')
    } else {
        $('.never-played').css('display', 'none')
    }
}
calculateHistoryLength();



document.onkeyup = function (data) {
    if ( data.which == 27 ) { //esc
      $.post('https://oe-aviator/exit', JSON.stringify({}));
      $('#main-container').css('display','none');
    }
  };
  