from enum import Enum


def _to_dict(e: Enum, skip_prefix=('NUM', '_')) -> dict:
    return {
        item.name: item.value
        for item in e
        if not any(item.name.startswith(p) for p in skip_prefix)
    }


def _remove_prefix(prefix: str, e: Enum, skip_prefix=('NUM', '_')) -> dict:
    n = len(prefix)
    return {
        item.name[n:]: item.value
        for item in e
        if not any(item.name.startswith(p) for p in skip_prefix)
    }


def _split_name(
        n_splits: int, e: Enum, skip_prefix=('NUM', '_'), lower=False) -> dict:
    items = {
        item.name.split('_', n_splits)[n_splits]: item.value
        for item in e
        if not any(item.name.startswith(p) for p in skip_prefix)
    }
    if lower:
        items = {k.lower(): v for k, v in items.items()}
    return items


def _lower_names(e: Enum) -> dict:
    return {item.name.lower(): item.value for item in e}


def _invert_dict(d: dict) -> dict:
    return {v: k for k, v in d.items()}