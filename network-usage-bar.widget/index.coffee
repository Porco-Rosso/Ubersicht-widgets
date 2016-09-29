command: """
    network-usage-bar.widget/lib/network.sh
"""
refreshFrequency: 2000

style: """
    // Change bar height
    bar-height = 2px

    // Align contents left or right
    widget-align = right

    // Position this where you want
    bottom 0px
    right 210px

    // Statistics text settings
    color #fff
    font-family Inconsolata, Helvetica Neue
    background rgba(#000, .0)
    padding 2px 2px 2px
    border-radius 5px

    .container
        width: 150px
        text-align: widget-align
        position: relative
        clear: both

    .widget-title
        text-align: widget-align

    .stats-container
        width: 100%
        margin-bottom 5px
        border-collapse collapse

    td
        font-size: 11px
        font-weight: 300
        color: rgba(#fff, .5)
        text-shadow: 0 1px 0px rgba(#000, .0)
        text-align: widget-align

    .widget-title
        font-size 0px
        text-transform uppercase
        font-weight bold

    .stat
        width: 50%
        .down
            float: left
            text-align left
        .up
            float: right
            text-align right

    .label-down
        font-size 8px
        text-transform uppercase
        font-weight bold
        float: left
        align: left

    .label-up
        font-size 8px
        text-transform uppercase
        font-weight bold
        float: right
        align: right

    .bar-container
        width: 100%
        height: bar-height
        border-radius: bar-height
        clear: both
        background: rgba(#fff, .5)
        position: absolute
        margin-bottom: 5px

    .bar
        height: bar-height
        transition: width .2s ease-in-out

    .bar:first-child
        border-radius: bar-height 0 0 bar-height
        float: left

    .bar:last-child
        border-radius: 0 bar-height bar-height 0
        float: right

    .bar-down
        background: rgba(#a826d3, .5)

    .bar-up
        background: rgba(#00C534, .5)
"""

render: -> """
        <div class="container">
        <div class="widget-title">Network</div>
        <table class="stats-container">
            <tr>
				<td class="label"><span class="label-down">down</span></td>
                <td class="label"><span class="label-up">up</span></td>
                
            </tr>
            <tr>
                <td class="stat"><span class="down"></span></td>
                <td class="stat"><span class="up"></span></td>
            </tr>
        </table>
        <div class="bar-container">
            <div class="bar bar-down"></div>
            <div class="bar bar-up"></div>
        </div>
    </div>
"""

update: (output, domEl) ->

    usage = (bytes) ->
        kb = bytes / 1024
        usageFormat kb

    usageFormat = (kb) ->
        if kb > 1024
            mb = kb / 1024
            "#{parseFloat(mb.toFixed(1))} MB/s"
        else
            "#{parseFloat(kb.toFixed(2))} KB/s"

    updateStat = (sel, currBytes, totalBytes) ->
        percent = (currBytes / totalBytes * 100).toFixed(1) + "%"
        $(domEl).find(".#{sel}").text usage(currBytes)
        $(domEl).find(".bar-#{sel}").css "width", percent

    args = output.split "^"

    downBytes = (Number) args[0]
    upBytes = (Number) args[1]

    totalBytes = downBytes + upBytes

    updateStat 'down', downBytes, totalBytes
    updateStat 'up', upBytes, totalBytes
