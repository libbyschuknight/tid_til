#!/usr/bin/env python3.7
# ## colleague at work did this for herself after my session at work about the python API

import iterm2
import asyncio
# This script was created with the "basic" environment which does not support adding dependencies
# with pip.
async def main(connection):
    # Your code goes here. Here's a bit of example code that adds a tab to the current window:
    app = await iterm2.async_get_app(connection)
    window = app.current_terminal_window
    if window is not None:
        left = window.current_tab.current_session
        right = await left.async_split_pane(vertical=True)
        await window.current_tab.async_set_title("Running: Rails server + Webpacker")
        await right.async_send_text("cd ~/storyjar/education\n")
        await right.async_send_text("eserver\n")
        await left.async_send_text("cd ~/storyjar/education\n")
        await left.async_send_text("./bin/webpack-dev-server\n")
        tab2 = await window.async_create_tab()
        await tab2.async_set_title("Running: Rails Console")
        await tab2.current_session.async_send_text("cd ~/storyjar/education\n")
        await tab2.current_session.async_send_text("be rails c\n")
        tab3 = await window.async_create_tab()
        await tab3.async_set_title("Running: Branch Management")
        await tab3.current_session.async_send_text("cd ~/storyjar/education\n")
    else:
        # You can view this message in the script console.
        print("No current window")
iterm2.run_until_complete(main)
