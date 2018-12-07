;;; Program to be run after the OS is booted.
after_boot:
        ld iy, alt_buf
        call display_copy
        call waitKey
        call flushkeys
        ld iy, screen_buf
        call display_copy
        call waitKey
        call flushkeys        
        jp after_boot

screen_buf:
        .fill 768, 0xee

alt_buf:
        .fill 768, 0
