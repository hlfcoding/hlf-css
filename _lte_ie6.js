jQuery.noConflict();
jQuery(document).ready(function($) 
{
    // get the CSS container width values
    var $container  = $('#doc');
    var min_width   = parseInt($container.css('min-width'));
    var max_width   = parseInt($container.css('max-width'));
    var margin      = parseInt($container.css('margin-left')) + parseInt($container.css('margin-right'));
    // resize the container on page load
    $(window).resize(function()
    {
        if ( ! isNaN(min_width) ||  ! isNaN(max_width))
        {
            resizeContainer();
        }
    });
    function resizeContainer()
    {
        var old_width = document.body.offsetWidth;
        var new_width = old_width;
        if ( ! isNaN(max_width) && old_width > max_width)
        {
            new_width = max_width - margin;
        }
        else if ( ! isNaN(min_width) && old_width < min_width)
        {
            new_width = min_width - margin;
        }
        else 
        {
            return;
        }
        new_width += 'px';
        // alert(margin + ", " + new_width + ", " + old_width + ", " + min_width + ", " + max_width);
        $container.css({width: new_width});
    }
});