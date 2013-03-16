windowResized: function() {
/*
A modified version of a script by the very talented and hardworking Dan Catt:
https://github.com/revdancatt/CAT540-guardian-picture-grid/blob/master/js/control.js
*/
        //  work out the image sizes
        var fit = parseInt($('body').innerWidth()/440, 10)+1;
        control.imgWidth = parseInt($('body').innerWidth()/fit, 10);
        control.imgHeight = parseInt(276 * control.imgWidth/460, 10);

        //  work out the font size
        //  at 440px wide the biggest font size should be 1em and line-height 1.2em
        //  220px = 0.5em
        //control.fontsize = ((control.imgWidth - 220)/220*0.5)+0.5;

        //  Now set them all up
        $('div.single_story').css({'width': control.imgWidth, 'height': control.imgHeight});
}