<?php
/**
 * Theme functions and definitions.
 */

if (!function_exists('nutritix_form_login')) {
    function nutritix_form_login() {
        if (nutritix_is_woocommerce_activated() && 'yes' === get_option('woocommerce_enable_myaccount_registration')) {
            $register_link = get_permalink(get_option('woocommerce_myaccount_page_id'));
        } else {
            $register_link = wp_registration_url();
        }
        ?>
        <div class="login-form-head">
            <span class="login-form-title"><?php esc_attr_e('Sign in', 'nutritix') ?></span>
            <span class="pull-right">
                <a class="register-link" href="<?php echo get_permalink(get_option('woocommerce_myaccount_page_id')); ?>"
                   title="<?php esc_attr_e('Register', 'nutritix'); ?>"><?php esc_attr_e('Create an Account', 'nutritix'); ?></a>
            </span>
        </div>
        <form class="nutritix-login-form-ajax" data-toggle="validator">
            <p>
                <label><?php esc_attr_e('Username or email', 'nutritix'); ?> <span class="required">*</span></label>
                <input name="username" type="text" required placeholder="<?php esc_attr_e('Username', 'nutritix') ?>">
            </p>
            <p>
                <label><?php esc_attr_e('Password', 'nutritix'); ?> <span class="required">*</span></label>
                <input name="password" type="password" required
                       placeholder="<?php esc_attr_e('Password', 'nutritix') ?>">
            </p>
            <button type="submit" data-button-action
                    class="btn btn-primary btn-block w-100 mt-1"><?php esc_html_e('Login', 'nutritix') ?></button>
            <input type="hidden" name="action" value="nutritix_login">
            <?php wp_nonce_field('ajax-nutritix-login-nonce', 'security-login'); ?>
        </form>
        <div class="login-form-bottom">
            <a href="<?php echo wp_lostpassword_url(get_permalink()); ?>" class="lostpass-link"
               title="<?php esc_attr_e('Lost your password?', 'nutritix'); ?>"><?php esc_attr_e('Lost your password?', 'nutritix'); ?></a>
        </div>
        <?php
    }
}

// Fix: evitar corte de palabras en tablas de descripciones (ficha tecnica).
add_action('wp_enqueue_scripts', function () {
    wp_register_style('nutritix-child-table-fix', false);
    wp_enqueue_style('nutritix-child-table-fix');
    wp_add_inline_style('nutritix-child-table-fix', '
        .content-area td, #primary td, .content-area th, #primary th,
        .woocommerce-Tabs-panel table td, .woocommerce-Tabs-panel table th {
            overflow-wrap: break-word !important;
            word-break: break-word !important;
            white-space: normal !important;
        }
    ');
});