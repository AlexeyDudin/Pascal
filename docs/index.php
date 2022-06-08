<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="./css/main.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <meta name=”viewport” content=”width=device-width" initial-scale=1.0”>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Roboto+Condensed&display=swap" rel="stylesheet">
    <script src="js/popup.js"></script>
    <title>Lab 5 and 6</title>
</head>
<body class="body">
    <header class="header">
        <div class="header__logo">
            <img src="images/Logo.svg">
        </div>
        <div class="header__menu-container">
            <div class="menu-container__subcontainer">
                <div class="menu-container__button header__menu-container_font" id="whatInCource">
                    <div>Что будет на курсе</div>
                </div>
                <div class="menu-container__button header__menu-container_font" id="questions">
                    <div href="">Вопросы</div>
                </div>
                <div class="menu-container__button header__menu-container_font" id="authors">
                    <div href="">Автор</div>
                </div>
                <div class="menu-container__button header__menu-container_font menu-container__button_last" id="headerWriteInCource" onclick="">
                    <div>Записаться на курс</div>
                </div>
            </div>
        </div>
    </header>

    <div class="main-content">
        <div class="main-content__first-block">
            <div class="main-content__first-block__text">
                <div class="text-montserrat main-content__dont-do-it_image">
                    Не <span class="pink-text">делай</span> это
                </div>
                <div class="text-roboto text-roboto__height text-roboto__width text-color__grey">
                    Онлайн-курс для творческих людей, о том, как управлять своим временем
                </div>
                <div class="menu-container__button header__menu-container_font menu-container__button_last first-block__button-write_width" >
                    <div>
                        Записаться на курс
                    </div>
                </div>
            </div>
            <div class="first-block__image">
                <img class="first-block__image_width" src="images/firstFragmentImages/firstFragment.webp">
            </div>
        </div>
        <div class="min-content__second-block">
            <div></div>
            <div></div>
            <div class="second-block__first-elem">
                <img src="images/secondFragmentImages/firstImage.svg">
                <div class="text-color__white text-roboto second-block__Roboto">
                        Для тех, у кого слишком много идей и слишком мало времени
                </div>
            </div>
            <div class="secondBlock__second-elem">
                <img src="images/secondFragmentImages/secondImage.svg">
                <div class="text-color__white text-roboto second-block__Roboto">
                    Метод «списка не дел», который позволит успевать и реализовывать
                </div>
            </div>
            <div class="secondBlock__third-elem">
                <img src="images/secondFragmentImages/thirdImage.svg">
                <div class="text-color__white text-roboto second-block__Roboto">
                    Курс научит творческих людей сосредоточиваться
                </div>
            </div>
            <div></div>
            <div></div>
        </div>
        <div class="main-content__third-block">
            <img id="firstImage" src="images/thirdFragmentImages/first.webp">
            <div class="thirdBlock__text" >
                <div class="text-montserrat third-block__text_height">
                    Ты не успеешь
                </div>
                <div class="text-roboto third-block__text-roboto-width third-block__subtext">
                    Всех творческих людей объединяет одна проблема - отсутствие времени на реализацию идей. Как прибавить суткам часы, рассмотрим в нашем курсе.
                </div>
            </div>
        </div>
        <div class="main-content__four-block">
            <div>
                <div class="text-montserrat third-block__text_height">
                    Опять дедлайн
                </div>
                <div class="text-roboto third-block__text-roboto-width third-block__subtext">
                    В мире, где столько всего интересного, когда же успевать жить?
                </div>
            </div>

            <img src="images/thirdFragmentImages/second.webp">
        </div>
        <div class="main-content__fifth-block">
            <div class="fifth-block__text">
                На курсе ты <span class="pink-text">сможешь</span>
            </div>
        </div>
        <div class="main-content__six-block">
            <div class="six-block__first-line">
                <div class="six-block__blackbox">
                    <img id="first-hand" class="six-block__image" src="./images/hands/FIrstHand.svg">
                    <div class="text-color__white text-roboto text-roboto__size black-box__text_margin">
                        Понять, что нужно делать, а что делать не стоит
                    </div>
                </div>
                <div class="six-block__blackbox">
                    <img id="second-hand" class="six-block__image" src="./images/hands/secondHand.svg">
                    <div class="text-color__white text-roboto text-roboto__size black-box__text_margin">
                       Перестать себя искусственно ограничивать.
                    </div>
                </div>
                <div class="six-block__blackbox">
                    <img id="third-hand" class="six-block__image" src="./images/hands/thirdHand.svg">
                    <div class="text-color__white text-roboto text-roboto__size black-box__text_margin">
                        Определить сильные стороны и начать использовать старые
                    </div>
                </div>
            </div>
            <div class="six-block__second-line">
                <div class="six-block__blackbox">
                    <img id="four-hand" class="six-block__image" src="./images/hands/fourHand.svg">
                    <div class="text-color__white text-roboto text-roboto__size black-box__text_margin">
                        Научиться достигать любой цели в 3 понятных шага
                    </div>
                </div>
                <div class="six-block__blackbox">
                    <img id="five-hand" class="six-block__image" src="./images/hands/fiveHand.svg">
                    <div class="text-color__white text-roboto text-roboto__size black-box__text_margin">
                        Сотрудничать эффективно и с правильными людьми
                    </div>
                </div>
                <div class="six-block__blackbox">
                    <img id="six-hand" class="six-block__image" src="./images/hands/sixHand.svg">
                    <div class="text-color__white text-roboto text-roboto__size black-box__text_margin">
                        Ограничить общение с клиентами и проведение совещаний
                    </div>
                </div>
            </div>
        </div>

    </div>

    <footer class="footer">
        <img class="footer__logo" src="images/WhiteLogo.svg">
    </footer>
</body>
</html>
