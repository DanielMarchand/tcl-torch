import torch
import torch.nn as nn
import pandas as pd
import json
import sys
import os

class SimpleNN(nn.Module):
    def __init__(self, input_size, output_size, neurons_per_layer, num_layers):
        super(SimpleNN, self).__init__()
        layers = [nn.Linear(input_size, neurons_per_layer), nn.ReLU()]
        for _ in range(num_layers - 1):
            layers += [nn.Linear(neurons_per_layer, neurons_per_layer), nn.ReLU()]
        layers.append(nn.Linear(neurons_per_layer, output_size))
        self.layers = nn.Sequential(*layers)

    def forward(self, x):
        return self.layers(x)

def train_model(model, train_loader, learning_rate, epochs, log_interval):
    criterion = nn.MSELoss()
    optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)
    
    for epoch in range(epochs):
        for batch_idx, (data, target) in enumerate(train_loader):
            optimizer.zero_grad()
            output = model(data)
            loss = criterion(output, target)
            loss.backward()
            optimizer.step()
        if epoch % log_interval == 0:
            print(f"Train Epoch: {epoch} [{batch_idx * len(data)}/{len(train_loader.dataset)} ({100. * batch_idx / len(train_loader):.0f}%)]\tLoss: {loss.item():.6f}")

def save_model_weights(model, directory):
    model_path = os.path.join(directory, 'model_weights.pth')
    torch.save(model.state_dict(), model_path)

def load_model_weights(model, directory):
    model_path = os.path.join(directory, 'model_weights.pth')
    model.load_state_dict(torch.load(model_path))


def get_script_path():
    """Get the absolute path of the running script."""
    return os.path.realpath(__file__)

def get_csv_path():
    """Get the absolute path to the ../resources/data/csv/ directory."""
    script_path = get_script_path()
    return os.path.join(os.path.dirname(script_path), '..', 'resources', 'data', 'csv')


def predict_and_save(model, data, directory):
    model.eval()  # Set the model to evaluation mode
    x = torch.tensor(data.iloc[:, 0].values, dtype=torch.float32).view(-1, 1)
    with torch.no_grad():
        predictions = model(x).view(-1).numpy()
    data['Predictions'] = predictions
    data.to_csv(os.path.join(directory, f"predictions.csv"), index=False)

def main(dir_path, mode):
    config_path = os.path.join(dir_path, 'config.json')
    with open(config_path, 'r') as f:
        config = json.load(f)

    training_data_path = os.path.join(get_csv_path(), config['trainingData'])
    data = pd.read_csv(training_data_path)
    x = torch.tensor(data.iloc[:, 0].values, dtype=torch.float32)
    y = torch.tensor(data.iloc[:, 1].values, dtype=torch.float32)

    model = SimpleNN(input_size=1, output_size=1, 
                     neurons_per_layer=config['neuronsPerLayer'],
                     num_layers=config['numLayers'])

    if mode == "train":
        train_loader = torch.utils.data.DataLoader(torch.utils.data.TensorDataset(x.view(-1, 1), y.view(-1, 1)),
                                                    batch_size=64)
        train_model(model, train_loader, config['learningRate'], config['epochs'], config['logInterval'])
        save_model_weights(model, dir_path)
    elif mode == "predict":
        load_model_weights(model, dir_path)
        predict_and_save(model, data, dir_path)

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python script.py <directory_path> <mode>")
        sys.exit(1)
    main(sys.argv[1], sys.argv[2])