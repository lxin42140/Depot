const { environment } = require('@rails/webpacker')
var webpack = require('webpack');

environment.plugins.append('Provide',
    new webpack.ProvidePlugin({
        Popper: ['popper.js', 'default'],
        $: 'jquery',
        // jquery: 'jquery'
        jQuery: 'jquery'
    })
)

module.exports = environment
