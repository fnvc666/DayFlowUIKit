//
//  DataManager.swift
//  ToDoListWithDesign
//
//
import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private init() { }
    
    private let tasksFileName = "tasks.json"
    private let profileInfo = "profileInfo.json"
    
    enum LoadableData {
        case tasks([Task])
        case profile([Profile])
    }

    func saveJSON(tasks: [Task]? = nil, profile: [Profile]? = nil, key: String) {
        var fileURL: URL
        let fileManager = FileManager.default
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        switch key {
            case "tasks":
                fileURL = documentsDir.appendingPathComponent(tasksFileName)
                do {
                    let data = try JSONEncoder().encode(tasks)
                    try data.write(to: fileURL)
                } catch {
                    print("Error during saving data: \(error)")
                }
            case "profile":
                fileURL = documentsDir.appendingPathComponent(profileInfo)
                do {
                    let data = try JSONEncoder().encode(profile)
                    try data.write(to: fileURL)
                } catch {
                    print("Error during saving data: \(error)")
                }
            default:
                print("Wrong key")
                break
        }
    }
    
    func saveProfile(_ info: [Profile]) {
        let fileManager = FileManager.default
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        
        let fileURL = documentsDir.appendingPathComponent(profileInfo)
        
        do {
            let data = try JSONEncoder().encode(info)
            try data.write(to: fileURL)
        } catch {
            print("Error during saving data: \(error)")
        }
    }

    func loadFromFile<T: Codable>(key: String) -> [T]? {
        var fileURL: URL
        let fileManager = FileManager.default
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        
        fileURL = documentsDir.appendingPathComponent(key)
                
        do {
            let data = try Data(contentsOf: fileURL)
            let decodeData = try JSONDecoder().decode([T].self, from: data)
            return decodeData
        } catch {
            print("Error during loading data: \(error)")
            return nil
        }
    }
    
    func removeData() {
        let fileManager = FileManager.default
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let profileURL = documentsDir.appendingPathComponent(profileInfo)
        let taskURL = documentsDir.appendingPathComponent(tasksFileName)
        
        do {
            if fileManager.fileExists(atPath: profileURL.path) {
                try fileManager.removeItem(at: profileURL)
            }
            
            if fileManager.fileExists(atPath: taskURL.path) {
                try fileManager.removeItem(at: taskURL)
            }
        } catch {
            print("Error removing data: \(error)")
        }
    }
    
    func loadFromTaskFile() -> [Task] {
        return loadFromFile(key: tasksFileName) ?? []
    }
    
    func loadFromProfileFile() -> [Profile] {
        return loadFromFile(key: profileInfo) ?? []
    }
}

