import { useState, useEffect } from 'react'
import { CATEGORIES, PRIORITIES, createTask } from '../Interfaces/Task'

/**
 * ItemForm – Görev ekle veya güncelle formu.
 * Props:
 *   onSubmit(task)  – yeni/güncellenmiş görevi üst bileşene iletir
 *   editingTask     – düzenleme modunda mevcut görev (null = ekleme modu)
 *   onCancel()      – düzenleme modundan çıkış
 */
export default function ItemForm({ onSubmit, editingTask, onCancel }) {
  const [title,    setTitle]    = useState('')
  const [category, setCategory] = useState(CATEGORIES[0])
  const [priority, setPriority] = useState(PRIORITIES[1])
  const [error,    setError]    = useState('')

  // Düzenleme modunda alanları doldur
  useEffect(() => {
    if (editingTask) {
      setTitle(editingTask.title)
      setCategory(editingTask.category)
      setPriority(editingTask.priority)
    } else {
      setTitle('')
      setCategory(CATEGORIES[0])
      setPriority(PRIORITIES[1])
    }
    setError('')
  }, [editingTask])

  function handleSubmit(e) {
    e.preventDefault()
    if (!title.trim()) {
      setError('Görev başlığı boş olamaz.')
      return
    }
    if (editingTask) {
      onSubmit({ ...editingTask, title: title.trim(), category, priority })
    } else {
      onSubmit(createTask(title, category, priority))
    }
    setTitle('')
    setCategory(CATEGORIES[0])
    setPriority(PRIORITIES[1])
    setError('')
  }

  const isEditing = Boolean(editingTask)

  return (
    <form
      onSubmit={handleSubmit}
      className="bg-white rounded-2xl shadow-md p-6 mb-6"
    >
      <h2 className="text-lg font-bold text-gray-800 mb-4">
        {isEditing ? '✏️ Görevi Düzenle' : '➕ Yeni Görev Ekle'}
      </h2>

      {/* Başlık */}
      <div className="mb-4">
        <label className="block text-sm font-medium text-gray-600 mb-1">
          Görev Başlığı
        </label>
        <input
          type="text"
          value={title}
          onChange={e => { setTitle(e.target.value); setError('') }}
          placeholder="Yapılacak görevi yaz..."
          className="w-full border border-gray-300 rounded-lg px-4 py-2 text-sm
                     focus:outline-none focus:ring-2 focus:ring-blue-400"
        />
        {error && <p className="text-red-500 text-xs mt-1">{error}</p>}
      </div>

      {/* Kategori + Öncelik */}
      <div className="flex gap-4 mb-5">
        <div className="flex-1">
          <label className="block text-sm font-medium text-gray-600 mb-1">
            Kategori
          </label>
          <select
            value={category}
            onChange={e => setCategory(e.target.value)}
            className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm
                       focus:outline-none focus:ring-2 focus:ring-blue-400"
          >
            {CATEGORIES.map(c => <option key={c}>{c}</option>)}
          </select>
        </div>
        <div className="flex-1">
          <label className="block text-sm font-medium text-gray-600 mb-1">
            Öncelik
          </label>
          <select
            value={priority}
            onChange={e => setPriority(e.target.value)}
            className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm
                       focus:outline-none focus:ring-2 focus:ring-blue-400"
          >
            {PRIORITIES.map(p => <option key={p}>{p}</option>)}
          </select>
        </div>
      </div>

      {/* Butonlar */}
      <div className="flex gap-3">
        <button
          type="submit"
          className="flex-1 bg-blue-600 hover:bg-blue-700 text-white font-semibold
                     rounded-lg py-2 text-sm transition-colors"
        >
          {isEditing ? 'Güncelle' : 'Ekle'}
        </button>
        {isEditing && (
          <button
            type="button"
            onClick={onCancel}
            className="flex-1 bg-gray-200 hover:bg-gray-300 text-gray-700 font-semibold
                       rounded-lg py-2 text-sm transition-colors"
          >
            İptal
          </button>
        )}
      </div>
    </form>
  )
}
