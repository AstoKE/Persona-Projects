import { useState } from 'react'
import ItemForm from '../Components/ItemForm'
import ItemList from '../Components/ItemList'

const INITIAL_TASKS = [
  { id: 1, title: 'React bileşen yapısını öğren', category: 'Eğitim',  priority: 'Yüksek', completed: true,  createdAt: '2024-04-01T10:00:00.000Z' },
  { id: 2, title: 'Tailwind CSS ile tasarım yap', category: 'Eğitim',  priority: 'Orta',   completed: false, createdAt: '2024-04-02T09:00:00.000Z' },
  { id: 3, title: 'GitHub reposunu oluştur',      category: 'İş',      priority: 'Yüksek', completed: false, createdAt: '2024-04-03T08:00:00.000Z' },
  { id: 4, title: 'Netlify\'e deploy et',          category: 'İş',      priority: 'Orta',   completed: false, createdAt: '2024-04-04T11:00:00.000Z' },
  { id: 5, title: 'Proje README yaz',              category: 'Kişisel', priority: 'Düşük',  completed: false, createdAt: '2024-04-05T14:00:00.000Z' },
]

/**
 * HomePage – Ana sayfa. Tüm CRUD state yönetimi burada.
 */
export default function HomePage() {
  const [tasks,       setTasks]       = useState(INITIAL_TASKS)
  const [editingTask, setEditingTask] = useState(null)

  // ── CREATE ──────────────────────────────────────────────
  function handleAdd(newTask) {
    setTasks(prev => [newTask, ...prev])
  }

  // ── UPDATE ──────────────────────────────────────────────
  function handleUpdate(updated) {
    setTasks(prev => prev.map(t => t.id === updated.id ? updated : t))
    setEditingTask(null)
  }

  // ── DELETE ──────────────────────────────────────────────
  function handleDelete(id) {
    if (!window.confirm('Bu görevi silmek istiyor musunuz?')) return
    setTasks(prev => prev.filter(t => t.id !== id))
  }

  // ── TOGGLE COMPLETE ─────────────────────────────────────
  function handleToggle(id) {
    setTasks(prev =>
      prev.map(t => t.id === id ? { ...t, completed: !t.completed } : t)
    )
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100">
      {/* Header */}
      <header className="bg-blue-700 shadow-lg">
        <div className="max-w-3xl mx-auto px-4 py-5 flex items-center justify-between">
          <div>
            <h1 className="text-white text-2xl font-bold tracking-tight">
              📋 Task Manager
            </h1>
            <p className="text-blue-200 text-xs mt-0.5">
              Web Geliştirme – JavaScript CRUD Projesi
            </p>
          </div>
          <span className="text-blue-200 text-sm hidden sm:block">
            React + Tailwind CSS
          </span>
        </div>
      </header>

      {/* Main */}
      <main className="max-w-3xl mx-auto px-4 py-8">
        {/* Form */}
        <ItemForm
          onSubmit={editingTask ? handleUpdate : handleAdd}
          editingTask={editingTask}
          onCancel={() => setEditingTask(null)}
        />

        {/* List */}
        <ItemList
          tasks={tasks}
          onDelete={handleDelete}
          onEdit={task => {
            setEditingTask(task)
            window.scrollTo({ top: 0, behavior: 'smooth' })
          }}
          onToggle={handleToggle}
        />
      </main>

      {/* Footer */}
      <footer className="text-center text-xs text-gray-400 py-6">
        Persona Projects – Web Geliştirme JavaScript Projesi
      </footer>
    </div>
  )
}
