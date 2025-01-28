def filter_on_odd_indices(elements_list):
    return [x for i, x in enumerate(elements_list) if i % 2 != 0 ]

def get_text_nodes(element_list):
    return list(map(lambda element:element.get_attribute('textContent'),element_list))
