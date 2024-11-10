from kittens.tui.handler import result_handler


def main(args):
    pass


speed = 5


@result_handler(no_ui=True)
def handle_result(args, result, target_window_id, boss):
    window = boss.window_id_map.get(target_window_id)
    if window is None:
        return

    direction = args[1]

    neighbors = boss.active_tab.current_layout.neighbors_for_window(
        window, boss.active_tab.windows
    )
    current_window_id = boss.active_tab.active_window

    left_neighbors = neighbors.get("left")
    right_neighbors = neighbors.get("right")
    top_neighbors = neighbors.get("top")
    bottom_neighbors = neighbors.get("bottom")

    # has a neighbor on both sides
    if direction == "left" and (left_neighbors and right_neighbors):
        # boss.active_tab.set_active_window(left_neighbors[0])
        boss.active_tab.resize_window("narrower", speed)
        # boss.active_tab.set_active_window(current_window_id)
    # only has left neighbor
    elif direction == "left" and left_neighbors:
        boss.active_tab.resize_window("wider", speed)
    # only has right neighbor
    elif direction == "left" and right_neighbors:
        boss.active_tab.resize_window("narrower", speed)

    # has a neighbor on both sides
    elif direction == "right" and (left_neighbors and right_neighbors):
        # boss.active_tab.set_active_window(left_neighbors[0])
        boss.active_tab.resize_window("wider", speed)
        # boss.active_tab.set_active_window(current_window_id)
    # only has left neighbor
    elif direction == "right" and left_neighbors:
        boss.active_tab.resize_window("narrower", speed)
    # only has right neighbor
    elif direction == "right" and right_neighbors:
        boss.active_tab.resize_window("wider", speed)

    # has a neighbor above and below
    elif direction == "up" and (top_neighbors and bottom_neighbors):
        # boss.active_tab.set_active_window(top_neighbors[0])
        boss.active_tab.resize_window("shorter", speed)
        # boss.active_tab.set_active_window(current_window_id)
    # only has top neighbor
    elif direction == "up" and top_neighbors:
        boss.active_tab.resize_window("taller", speed)
    # only has bottom neighbor
    elif direction == "up" and bottom_neighbors:
        boss.active_tab.resize_window("shorter", speed)

    # has a neighbor above and below
    elif direction == "down" and (top_neighbors and bottom_neighbors):
        # boss.active_tab.set_active_window(top_neighbors[0])
        boss.active_tab.resize_window("taller", speed)
        # boss.active_tab.set_active_window(current_window_id)
    # only has top neighbor
    elif direction == "down" and top_neighbors:
        boss.active_tab.resize_window("shorter", speed)
    # only has bottom neighbor
    elif direction == "down" and bottom_neighbors:
        boss.active_tab.resize_window("taller", speed)
