import numpy as np
import pytest
from app.classifier import classify, classify_batch, CLASSES


def test_classify_returns_dict():
    image = np.zeros((28, 28), dtype=np.uint8)
    result = classify(image)
    assert isinstance(result, dict)


def test_classify_has_required_keys():
    image = np.zeros((28, 28), dtype=np.uint8)
    result = classify(image)
    assert "prediction" in result
    assert "confidence" in result
    assert "scores" in result


def test_prediction_is_valid_class():
    image = np.zeros((28, 28), dtype=np.uint8)
    result = classify(image)
    assert result["prediction"] in CLASSES


def test_confidence_between_zero_and_one():
    image = np.zeros((28, 28), dtype=np.uint8)
    result = classify(image)
    assert 0.0 <= result["confidence"] <= 1.0


def test_batch_returns_one_result_per_image():
    images = np.zeros((3, 28, 28), dtype=np.uint8)
    results = classify_batch(images)
    assert len(results) == 3


def test_wrong_shape_raises_error():
    bad_input = np.zeros((10, 10), dtype=np.uint8)
    with pytest.raises(ValueError):
        classify_batch(bad_input)
