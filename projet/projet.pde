/**
* Projet Creation Numérique
* Arga Théo & Alisa Hasanli
* (c) 2022
*
* [description projet]
*
**/

PImage photo;

 class sticks
{
    private PImage img;
    private PVector center;

    public sticks(PImage im, PVector ctr)
    {
        img = im;
        center = ctr;
    }



}

void settings() 
{
    photo = loadImage("img.png");
    int h,w;
    float r = photo.width / (float)photo.height;
    h = (int)(min(displayHeight,displayWidth) * 0.8);
    w = java.lang.Math.round(h * r);
    size(w,h);
    
    print("h :" + h + " w :" + w + " r :" +r);

}


void setup() 
{
    background(0);

}

void draw() {
    photo.resize(width,height);
    image(photo,0,0);
}
