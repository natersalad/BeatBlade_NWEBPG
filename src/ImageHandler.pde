class ImageHandler {
    PImage background;
    PImage background2;
    PImage easyEmoji;
    PImage hardEmoji;
    PImage menu;
    PImage monster;
    PImage playerAttack;
    PImage playerDefend;
    PImage playerIcon;
    PImage quitEmoji;
    PImage rhino;
    PImage tigerNinja;

    void loadImages() {
        background = loadImage("assets/images/Background.png");
        background2 = loadImage("assets/images/Background2.png");
        easyEmoji = loadImage("assets/images/EasyEmoij.png");
        hardEmoji = loadImage("assets/images/HardEmoij.png");
        menu = loadImage("assets/images/Menu.png");
        monster = loadImage("assets/images/Monster.png");
        playerAttack = loadImage("assets/images/PlayerAttack.png");
        playerDefend = loadImage("assets/images/PlayerDefend.png");
        playerIcon = loadImage("assets/images/PlayerIcon.png");
        quitEmoji = loadImage("assets/images/QuitEmoji.png");
        rhino = loadImage("assets/images/Rhino.png");
        tigerNinja = loadImage("assets/images/TigerNinja.png");
    }
}
