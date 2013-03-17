/* 
Image layout control. Adapted from https://github.com/revdancatt/CAT540-guardian-picture-grid/blob/master/js/control.js by Dan Catt. 
*/
control = {
    
    imgWidth: 460,
    imgHeight: 245,
    fontsize: '1em',
    pageY: 100,

    init: function() {
        //  Do calculations if the window gets resized
        $(window).bind('resize', function() { utils.windowResized(); });

        //  call the resize function in a secon after page load, juat 'cause
        setTimeout("utils.windowResized()", 1000);
    }
};

utils = {
    
    log: function(msg) {
        try {
            console.log(msg);
        } catch(er) {
        }
    },

    windowResized: function() {
        //  work out the image sizes
        var fit = parseInt($('body').innerWidth()/460, 10)+1;
        control.imgWidth = parseInt($('body').innerWidth()/fit, 10);
        control.imgHeight = parseInt(245 * control.imgWidth/460, 10);
        //  work out the font size
        //  at 460px wide the biggest font size should be 1em and line-height 1.2em
        //  220px = 0.5em
        control.fontsize = ((control.imgWidth - 220)/220*0.5)+0.5;
        //  Now set them all up
        $('div.container').css({'width': control.imgWidth, 'height': control.imgHeight, 'font-size': control.fontsize + 'em'});
    }
};