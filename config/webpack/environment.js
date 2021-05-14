const { environment } = require('@rails/webpacker')
var webpack = require('webpack');

module.exports = environment

environment.plugins.append('Provide',
    new webpack.ProvidePlugin({
        Popper: ['popper.js', 'default'],
        $: 'jquery/src/jquery',
        jquery: 'jquery/src/jquery',
        jQuery: 'jquery/src/jquery'
    })
)